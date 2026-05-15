Outlook,Temperature,Humidity,Wind,PlayTennis
Sunny,Hot,High,Weak,No
Sunny,Hot,High,Strong,No
Overcast,Hot,High,Weak,Yes
Rain,Mild,High,Weak,Yes
Rain,Cool,Normal,Weak,Yes
Rain,Cool,Normal,Strong,No
Overcast,Cool,Normal,Strong,Yes
Sunny,Mild,High,Weak,No
Sunny,Cool,Normal,Weak,Yes
Rain,Mild,Normal,Weak,Yes
Sunny,Mild,Normal,Strong,Yes
Overcast,Mild,High,Strong,Yes
Overcast,Hot,Normal,Weak,Yes
Rain,Mild,High,Strong,No
import csv
import math

def load_data(filename):
    """Loads CSV data into a list of dictionaries."""
    with open(filename, 'r') as f:
        reader = csv.DictReader(f)
        data = [row for row in reader]
    return data

def calculate_entropy(data):
    """Calculates the entropy of the dataset based on the target variable."""
    if not data:
        return 0

    # Count frequency of each class label (Yes/No)
    total_rows = len(data)
    target_counts = {}
    for row in data:
        label = row['PlayTennis'] # Target column
        target_counts[label] = target_counts.get(label, 0) + 1

    # Calculate Entropy: -Sum(p * log2(p))
    entropy = 0
    for count in target_counts.values():
        probability = count / total_rows
        entropy -= probability * math.log2(probability)
        
    return entropy

def calculate_information_gain(data, attribute):
    """Calculates Information Gain for a specific attribute."""
    total_entropy = calculate_entropy(data)
    total_rows = len(data)

    # Split data based on the unique values of the attribute
    attribute_values = {}
    for row in data:
        val = row[attribute]
        if val not in attribute_values:
            attribute_values[val] = []
        attribute_values[val].append(row)

    # Calculate Weighted Entropy of children
    weighted_entropy = 0
    for val, subset in attribute_values.items():
        probability = len(subset) / total_rows
        weighted_entropy += probability * calculate_entropy(subset)

    # Gain = Total Entropy - Weighted Entropy
    return total_entropy - weighted_entropy

def id3(data, attributes):
    """
    Recursive function to build the Decision Tree.
    data: List of data rows (dicts)
    attributes: List of attribute names available to split on
    """

    # 1. Base Case: All examples have the same label
    labels = [row['PlayTennis'] for row in data]
    if len(set(labels)) == 1:
        return labels[0]

    # 2. Base Case: No attributes left to split
    if not attributes:
        # Return majority class
        return max(set(labels), key=labels.count)

    # 3. Find the best attribute to split on
    best_attr = None
    max_gain = -1

    for attr in attributes:
        gain = calculate_information_gain(data, attr)
        if gain > max_gain:
            max_gain = gain
            best_attr = attr

    # 4. Create the tree node
    tree = {best_attr: {}}

    # Remove best attribute from valid attributes list for next recursion
    remaining_attributes = [a for a in attributes if a != best_attr]

    # 5. Split data and recurse
    unique_values = set(row[best_attr] for row in data)
    for val in unique_values:
        subset = [row for row in data if row[best_attr] == val]
        subtree = id3(subset, remaining_attributes)
        tree[best_attr][val] = subtree

    return tree

def classify(sample, tree):
    """Classifies a new sample using the built tree."""
    # If the current node is a string (Leaf node), return it
    if not isinstance(tree, dict):
        return tree

    # Get the root attribute of the current tree
    root_attr = list(tree.keys())[0]

    # Get the value of that attribute in the sample
    sample_val = sample.get(root_attr)

    # Check if we have a branch for this value
    if sample_val in tree[root_attr]:
        subtree = tree[root_attr][sample_val]
        return classify(sample, subtree)
    else:
        return "Unknown" # Sample has a value not seen in training

if __name__ == "__main__":
    filename = "training_data_set_for_ex_2.csv"
    
    try:
        data = load_data(filename)
        
        # Get list of attributes (exclude the target 'PlayTennis')
        attributes = list(data[0].keys())
        attributes.remove('PlayTennis')
        
        print("Building Decision Tree...")
        decision_tree = id3(data, attributes)
        
        # Pretty print the dictionary structure
        import pprint
        print("\nGenerated Decision Tree:")
        pprint.pprint(decision_tree)
        
        print("\n-------------------------")
        
        # Classify a New Sample
        new_sample = {
            'Outlook': 'Rain',
            'Temperature': 'Cool',
            'Humidity': 'High',
            'Wind': 'Strong'
        }
        
        # Executing the classification for the hardcoded sample
        prediction = classify(new_sample, decision_tree)
        print(f"\nPrediction for new sample: {prediction}")
        
    except FileNotFoundError:
        print(f"Error: The file '{filename}' was not found. Please ensure it is in the same directory.")
