# Project Summary

## Project Description
The project aims to analyze and model the Amazon co-purchase network using a graph where products are vertices and co-purchases are edges. The dataset, obtained through a web crawler, comprises 262,111 vertices and 1,234,877 edges. The goal is to identify strongly connected components (SCCs) to suggest sets of products to be sold together.

## Iterative Tarjan Algorithm
The Tarjan algorithm was chosen to identify SCCs in the network. An optimized linear-time version was implemented, using iterative depth-first search with a Stack data structure to efficiently handle the large amount of data.

## Ruby Implementation
The solution was implemented in Ruby (version 3.2.2), with a simple structure consisting of two main classes: the graph class, responsible for representing the graph's behavior and utilizing the selected algorithms, and a main class organizing method execution. Automated tests were developed using RSpec to ensure code quality.

## Code Execution
To simplify execution, a Makefile was provided. Use `make build` to install dependencies and `make run` to execute the main code. Automated tests can be run with `make test`. Ensure that Ruby is installed on the machine.

## Results
The analysis reveals 10,095 SCCs in the dataset, with an average of approximately 25 vertices per component. The distribution of component sizes varies significantly, indicating complexity in interconnections. Sets of interest were highlighted, providing detailed information on products in promising kits.

## Limitations
Runtime may vary with dataset size, affecting efficiency. The representativeness of SCCs is limited, requiring a more detailed analysis. The algorithm provides only product indices, necessitating manual search for detailed information.

## Conclusions and Future Improvements
The study provides valuable insights and underscores the importance of overcoming challenges to enhance the practical utility of the algorithm. A more in-depth analysis of SCCs is suggested, along with the inclusion of visual representations to enrich result presentation.
