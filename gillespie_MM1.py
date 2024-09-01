import numpy as np
import matplotlib.pyplot as plt

class MM1QueueGillespie:
    def __init__(self, lambd, mu, x0=0, seed=None):
        self.lambd = lambd  # Arrival rate
        self.mu = mu        # Service rate
        self.x0 = x0        # Initial number of customers
        if seed is not None:
            np.random.seed(seed)

    def gillespie_ssa(self, n_steps=200):
        x = self.x0
        t = 0
        times = [t]
        states = [x]

        for _ in range(n_steps):
            # Calculate rates
            r1 = self.lambd       # Arrival rate (constant)
            r2 = self.mu * x      # Service rate (depends on current number of customers)
            r_total = r1 + r2     # Total rate

            # Time until next event
            delta_t = np.random.exponential(1 / r_total)
            t += delta_t

            # Determine the next event
            if np.random.uniform() < r1 / r_total:
                x += 1  # Arrival event
            else:
                if x > 0:
                    x -= 1  # Service event

            times.append(t)
            states.append(x)

        return times, states

    def plot_path(self, times, states):
        plt.figure(figsize=(10, 5))
        plt.step(times, states, where='post', color='blue')
        plt.xlabel('Time')
        plt.ylabel('Number of Customers')
        plt.title('M/M/1 Queue Simulation using Gillespie SSA'+'\n'
                  + f'Lampda ={self.lambd:.3f}' + f' Mu ={self.mu:.3f}')
        plt.grid(True)
        plt.show()

    def calculate_steady_state_metrics(self, times, customer_counts):


        rho = self.lambd / self.mu
        if rho < 1:
            total_time = times[-1]
            L = np.trapezoid(customer_counts, times) / total_time #intregate number of customers over time and divide by total time
            Lq = L - (self.lambd / self.mu)
            W = L / self.lambd
            Wq = W - (1 / self.mu)
            return L, Lq, W, Wq, rho
        else:
            return None
def main():
    # Parameters
    inv_lambda = 1  # Mean time between arrivals
    inv_mu = 20     # Mean service time
    lambd = 1 / inv_lambda
    mu = 1 / inv_mu
    x0 = 0
    seed = 42

    # Initialize the simulation
    sim = MM1QueueGillespie(lambd=lambd, mu=mu, x0=x0, seed=seed)

    # Run Gillespie SSA simulation
    times, states = sim.gillespie_ssa(n_steps=200)

    # Plot the path
    sim.plot_path(times, states)

    # Calculate steady-state metrics
    metrics = sim.calculate_steady_state_metrics(times,states)
    if metrics:
        L, Lq, W, Wq, rho = metrics
        print(f"Steady-State Metrics:\n"
              f"L (mean number of customers): {L:.3f}\n"
              f"Lq (mean length of the queue): {Lq:.3f}\n"
              f"W (mean time in the system): {W:.3f}\n"
              f"Wq (mean time in the queue): {Wq:.3f}\n"
              f"Rho (server utilization): {rho:.3f}")
    else:
        print("The system is unstable (λ >= μ), so a steady-state distribution does not exist.")


if __name__ == "__main__":
    main()
