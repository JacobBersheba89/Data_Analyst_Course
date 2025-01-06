import matplotlib.pyplot as plt
import numpy as np

# Simple line plot
x = np.linspace(0, 10, 100)
y = np.sin(x)

plt.plot(x, y)
plt.title('Simple Line Plot')
plt.xlabel('x')
plt.ylabel('sin(x)')
plt.show()