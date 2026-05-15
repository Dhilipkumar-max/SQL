import csv
import math
import random

def load_nn_data(filename):
    inputs, targets = [], []
    with open(filename, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            inputs.append([float(row['input1']), float(row['input2'])])
            targets.append([float(row['target'])])
    return inputs, targets

def sigmoid(x):
    return 1 / (1 + math.exp(-x))

def sigmoid_derivative(x):
    return x * (1 - x)

class NeuralNetwork:
    def __init__(self, input_nodes, hidden_nodes, output_nodes):
        # Weights initialized randomly
        self.w_ih = [[random.uniform(-1, 1) for _ in range(hidden_nodes)] for _ in range(input_nodes)]
        self.w_ho = [[random.uniform(-1, 1) for _ in range(output_nodes)] for _ in range(hidden_nodes)]
        
        self.bias_h = [random.uniform(-1, 1) for _ in range(hidden_nodes)]
        self.bias_o = [random.uniform(-1, 1) for _ in range(output_nodes)]

    def train(self, inputs, targets, lr):
        # --- Forward Pass ---
        
        # Input -> Hidden
        h_in = [sum(inputs[i] * self.w_ih[i][j] for i in range(len(inputs))) + self.bias_h[j] for j in range(len(self.bias_h))]
        h_out = [sigmoid(x) for x in h_in]

        # Hidden -> Output
        o_in = [sum(h_out[j] * self.w_ho[j][k] for j in range(len(h_out))) + self.bias_o[k] for k in range(len(self.bias_o))]
        final_out = [sigmoid(x) for x in o_in]

        # --- Backpropagation ---
        
        # 1. Output Error (Target - Actual)
        out_errors = [targets[k] - final_out[k] for k in range(len(targets))]
        out_gradients = [out_errors[k] * sigmoid_derivative(final_out[k]) for k in range(len(final_out))]

        # 2. Hidden Error (Back-propagated from Output)
        h_errors = [sum(out_gradients[k] * self.w_ho[j][k] for k in range(len(out_gradients))) for j in range(len(h_out))]
        h_gradients = [h_errors[j] * sigmoid_derivative(h_out[j]) for j in range(len(h_out))]

        # 3. Update Weights and Biases
        for j in range(len(h_out)):
            for k in range(len(final_out)):
                self.w_ho[j][k] += out_gradients[k] * h_out[j] * lr

        for i in range(len(inputs)):
            for j in range(len(h_out)):
                self.w_ih[i][j] += h_gradients[j] * inputs[i] * lr
                
        # Note: The original printed code omitted bias updates here. 
        # For a more perfect network, you would normally update them like this:
        # for k in range(len(final_out)):
        #     self.bias_o[k] += out_gradients[k] * lr
        # for j in range(len(h_out)):
        #     self.bias_h[j] += h_gradients[j] * lr

        return final_out

if __name__ == "__main__":
    inputs, targets = load_nn_data("training_data_set_for_ex_3.csv")

    nn = NeuralNetwork(2, 2, 1)

    print("Training Neural Network via Backpropagation...")
    
    lr = 0.1
    epochs = 20000

    for epoch in range(epochs):
        total_error = 0
        
        for i in range(len(inputs)):
            # Train and get the output of this specific iteration
            pred = nn.train(inputs[i], targets[i], lr)
            
            # Accumulate Squared Error: (Target - Actual)^2
            total_error += (targets[i][0] - pred[0]) ** 2

        # Print progress every 2000 epochs
        if epoch % 2000 == 0:
            mse = total_error / len(inputs)
            print(f"Epoch {epoch:5d} | Mean Squared Error: {mse:.6f}")

    print("\nFinal Results:")
    for i in range(len(inputs)):
        # Final pass with lr=0 to see final state
        final_pred = nn.train(inputs[i], targets[i], 0)
        print(f"Input: {inputs[i]} -> Predicted: {final_pred[0]:.4f} (Target: {targets[i][0]})")
input1,input2,target
0,0,0
0,1,1
1,0,1
1,1,0

