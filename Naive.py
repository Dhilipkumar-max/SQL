text,label
The new smartphone has a great high resolution camera,tech
Artificial intelligence and machine learning are transforming software,tech
The local team won the basketball championship last night,sports
A new quantum computer breaks previous calculation records,tech
The striker scored three goals in the football match,sports
Tech companies are investing heavily in new processors,tech
The latest software update fixes bugs and improves performance,tech
The famous tennis player won the grand slam tournament,sports
import csv
import math
import re
from collections import Counter

def tokenize(text):
    """Simple tokenizer to lowercase and find words."""
    return re.findall(r'\w+', text.lower())

def load_data(filename):
    with open(filename, 'r') as f:
        reader = csv.DictReader(f)
        return [(tokenize(row['text']), row['label']) for row in reader]

def train_naive_bayes(train_data):
    # Count classes and words per class
    class_counts = Counter()
    word_counts = {} # {label: {word: count}}
    vocab = set()

    for words, label in train_data:
        class_counts[label] += 1
        if label not in word_counts:
            word_counts[label] = Counter()
        for word in words:
            word_counts[label][word] += 1
            vocab.add(word)
            
    return class_counts, word_counts, vocab

def classify(doc, class_counts, word_counts, vocab):
    total_docs = sum(class_counts.values())
    best_label = None
    max_prob = -float('inf')

    for label in class_counts:
        # Start with log(P(Class)) to avoid underflow
        log_prob = math.log(class_counts[label] / total_docs)
        
        # Total words in this class (for denominator)
        total_words_in_class = sum(word_counts[label].values())
        
        # P(word|class) with Laplace smoothing
        for word in doc:
            if word in vocab:
                count = word_counts[label].get(word, 0) + 1
                denom = total_words_in_class + len(vocab)
                log_prob += math.log(count / denom)
                
        if log_prob > max_prob:
            max_prob = log_prob
            best_label = label
            
    return best_label

def calculate_metrics(test_data, class_counts, word_counts, vocab):
    # We will measure for the 'tech' class
    target_class = 'tech'
    
    tp = fp = fn = tn = 0
    
    for words, actual in test_data:
        predicted = classify(words, class_counts, word_counts, vocab)
        
        if predicted == target_class and actual == target_class: tp += 1
        elif predicted == target_class and actual != target_class: fp += 1
        elif predicted != target_class and actual == target_class: fn += 1
        else: tn += 1

    accuracy = (tp + tn) / len(test_data)
    precision = tp / (tp + fp) if (tp + fp) > 0 else 0
    recall = tp / (tp + fn) if (tp + fn) > 0 else 0
    
    return accuracy, precision, recall

# Execution
if __name__ == "__main__":
    data = load_data('training_data_set_for_ex_5.csv')
    
    # Split 75% train, 25% test
    split = int(len(data) * 0.75)
    
    train_set, test_set = data[:split], data[split:]
    
    class_counts, word_counts, vocab = train_naive_bayes(train_set)
    
    acc, prec, rec = calculate_metrics(test_set, class_counts, word_counts, vocab)
    
    print(f"Metrics for class 'tech':")
    print(f"Accuracy: {acc:.2f}")
    print(f"Precision: {prec:.2f}")
    print(f"Recall: {rec:.2f}")
