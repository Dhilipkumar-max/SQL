# Program :

import csv

def load_data(filename):
    with open(filename, 'r') as f:
        reader = csv.reader(f)
        data = list(reader)
        header = data[0]
        examples = data[1:]
    return header, examples

def candidate_elimination(examples):
    # Initialize S (specific boundary) and G (general boundary)
    num_attributes = len(examples[0]) - 1
    S = ['0'] * num_attributes
    G = [['?'] * num_attributes]

    for example in examples:
        attributes, label = example[:-1], example[-1]
        
        if label == "Yes": # Positive example
            # Update S
            for i in range(num_attributes):
                if S[i] == '0':
                    S[i] = attributes[i]
                elif S[i] != attributes[i]:
                    S[i] = '?'
            
            # Remove inconsistent hypotheses from G
            G = [g for g in G if all(
                g[i] == '?' or g[i] == attributes[i] for i in range(num_attributes)
            )]
            
        else: # Negative example
            # Specialize G
            new_G = []
            for g in G:
                for i in range(num_attributes):
                    if g[i] == '?':
                        for val in set(attr[i] for attr in examples):
                            if val != attributes[i]:
                                new_hypothesis = g.copy()
                                new_hypothesis[i] = val
                                if all(
                                    new_hypothesis[j] == '?' or new_hypothesis[j] == attributes[j]
                                    for j in range(num_attributes)
                                ) is False:
                                    new_G.append(new_hypothesis)
            G = new_G
            
    return S, G

if __name__ == "__main__":
    header, examples = load_data("training_data.csv")
    S, G = candidate_elimination(examples)
    print("Final Specific Boundary (S):", S)
    print("Final General Boundary (G):", G)
Sky,Temp,Humidity,Wind,Water,Forecast,EnjoySport
Sunny,Warm,Normal,Strong,Warm,Same,Yes
Sunny,Warm,High,Strong,Warm,Same,Yes
Rainy,Cold,High,Strong,Warm,Change,No
Sunny,Warm,High,Strong,Cool,Change,Yes
