# AI-Enabled Digital Twin for Smart Grid Carbon Reduction

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.XXXXXXX.svg)](https://doi.org/10.5281/zenodo.XXXXXXX)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![MATLAB](https://img.shields.io/badge/MATLAB-R2023a-blue.svg)

Complete implementation for the manuscript:

> **"Performance Analysis of Multi-Strategy Optimization in AI-Enabled Digital Twin for Smart Grid Carbon Reduction: A Comparative Study"**  
> *Scientific Reports* (Under Review)  
> Authors: Sakthivel S, M. Arivukarasi, G. Charulatha, J. Nithisha, Abirami B, Jaithunbi AK, V. Suresh Kumar  
> DOI: [10.XXXX/XXXXX](https://doi.org/10.XXXX/XXXXX)

## 📋 Overview

This repository contains the complete digital twin framework for optimizing multi-energy storage systems (battery, thermal, hydrogen) in smart grids. The framework implements and compares three optimization strategies:

1. **Rule-Based (RB)** control – Simple heuristic approach
2. **Model Predictive Control (MPC)** – 6-hour look-ahead optimization  
3. **Genetic Algorithm (GA)** – Day-ahead Pareto-optimal scheduling

Key features:
- AI-powered forecasting (LSTM for load/renewable prediction)
- High-fidelity storage models with degradation constraints
- Comprehensive performance metrics (carbon, cost, renewable penetration)
- Sensitivity and uncertainty analysis
- Real-data validation with Pecan Street Dataport

## 🚀 Quick Start

### Prerequisites
- **MATLAB R2023a** or later
- **Global Optimization Toolbox** (required for GA)
- **Statistics and Machine Learning Toolbox** (for LSTM models)
- **~5GB disk space** for data and results

### Installation
```bash
git clone https://github.com/sakthi0707/Digital-twin-mes-optimization.git
cd Digital-twin-mes-optimization
