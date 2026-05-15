import csv

def load_data(filename):
    with open(filename, 'r') as f:
        reader = csv.DictReader(f)
        return list(reader)

def diagnose(data, symptoms):
    # 1. Calculate Prior Probabilities: P(Corona=1) and P(Corona=0)
    total = len(data)
    
    corona_pos = [row for row in data if row['Corona'] == '1']
    corona_neg = [row for row in data if row['Corona'] == '0']
    
    p_corona = len(corona_pos) / total
    p_no_corona = len(coronba_neg) / total
    
    # 2. Calculate Likelihoods for each symptom
    # P(Symptom | Corona)
    prob_pos = p_corona
    prob_neg = p_no_corona
    
    for symptom, value in symptoms.items():
        # Count how many people with Corona have this specific symptom value
        pos_match = len([r for r in corona_pos if r[symptom] == str(value)])
        neg_match = len([r for r in corona_neg if r[symptom] == str(value)])
        
        # Apply Laplace Smoothing to avoid multiplying by zero
        prob_pos *= (pos_match + 1) / (len(corona_pos) + 2)
        prob_neg *= (neg_match + 1) / (len(corona_neg) + 2)

    # 3. Normalize to get actual percentages
    total_prob = prob_pos + prob_neg
    
    final_score = prob_pos / total_prob
    
    return final_score

# --- Execution ---
if __name__ == "__main__":
    dataset = load_data('training_data_set_for_ex_6.csv')

    # Test Patient: Fever=1, Cough=0, BreathBreath=1
    patient_symptoms = {'Fever': 1, 'Cough': 0, 'BreathBreath': 1}

    probability = diagnose(dataset, patient_symptoms)

    print(f"Based on symptoms {patient_symptoms}:")
    print(f"Probability of Corona: {probability:.2%}")

Fever,Cough,BreathBreath,Corona
1,1,1,1
1,0,1,1
0,1,0,0
1,0,0,0
0,0,1,0
1,1,0,1
1,0,1,1
0,0,0,0
1,1,1,1
0,1,1,0
