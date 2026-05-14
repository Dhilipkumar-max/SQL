#include <stdio.h>
#include <conio.h>
#include <graphics.h>

void main() {
    // 1. Initialize Graphics Variables
    int gd = DETECT, gm;
    int i, x, y;
    
    // Data arrays based on the image
    int n[] = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100};
    float time[] = {0.000000, 0.054945, 0.109890, 0.054945, 0.054945, 
                    0.054945, 0.054945, 0.054945, 0.054945, 0.054945};

    // 2. Initialize Graphics Mode
    // Change "C:\\TURBOC3\\BGI" to your actual BGI folder path
    initgraph(&gd, &gm, "C:\\TURBOC3\\BGI");

    // 3. Print the Table (Top Left)
    printf("n\tTime(s)\n");
    for(i = 0; i < 10; i++) {
        printf("%d\t%f\n", n[i], time[i]);
    }

    // 4. Draw the Graph Axes
    // line(x1, y1, x2, y2)
    line(50, 400, 600, 400); // X-axis (Input Size)
    line(50, 400, 50, 150);  // Y-axis (Time)
    outtextxy(480, 410, "Input Size (n)");

    // 5. Draw the Legend (Top Right)
    setcolor(RED);
    outtextxy(400, 100, "Worst");
    setcolor(BROWN);
    outtextxy(400, 120, "Average");
    setcolor(GREEN);
    outtextxy(400, 140, "Best");

    // 6. Plot the Curves
    for(i = 0; i < 9; i++) {
        x = 50 + (n[i] * 5);
        
        // Worst Case (Top Curve)
        setcolor(RED);
        line(50 + (i*50), 300 - (i*15), 50 + ((i+1)*50), 300 - ((i+1)*15));

        // Average Case (Middle Curve)
        setcolor(BROWN);
        line(50 + (i*50), 330 - (i*10), 50 + ((i+1)*50), 330 - ((i+1)*10));

        // Best Case (Bottom Curve - Constant/Linear)
        setcolor(GREEN);
        line(50 + (i*50), 380, 50 + ((i+1)*50), 378);
    }

    getch();
    closegraph();
}
