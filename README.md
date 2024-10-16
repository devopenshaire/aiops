# AIOps: Exploring and Testing Open-Source AI Tools

Welcome to the AIOps project! This repository aims to explore, test, and integrate various open-source software and tools in the Artificial Intelligence (AI) world. It provides an environment where you can easily set up and test tools using Docker and Makefile automation.

## Features

- **Cross-platform support**: Automatically detects the operating system (Linux, macOS, Windows) and adjusts settings for Docker and server configuration.
- **Modular structure**: The project is designed to be modular, making it easy to add or remove components.
- **Easy-to-use Makefile**: Simplifies managing the development environment, running Docker containers, and controlling the AI tool stack.
- **AI Tool Integration**: The project leverages AI tools like [Ollama](https://ollama.ai), making it easier to experiment with different models.

## Requirements

- [Docker](https://www.docker.com/get-started)
- [Make](https://www.gnu.org/software/make/)

Make sure to have both installed on your system before proceeding.

## Getting Started

To get the project up and running, follow these steps:

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/aiops.git
   cd aiops
   ```
2. **Run the Project** 
    The Makefile provides a set of commands to help you set up and manage the environment.
    To start the AI environment, simply run:
    ```bash
    make
    ```
    This will:

    - Detect your operating system and configure the appropriate settings.
    - Start the required Docker containers and the AI services.
3. **Check the Server** 
    Host If you want to see the server host that is being used (especially if you're on macOS or using a specific network setup), you can use the following command:

    ```bash
    make view_server_host
    ```
4. **Manage the Ollama AI Tool**
    The project integrates Ollama, which can be started or stopped using the following commands:

    - Start Ollama:
    ```bash
    make ollama serve
    ```
    - Stop Ollama:

    ```bash
    make ollama stop
    ```
## File Structure
```
aiops/
│
├── Makefile               # Main makefile to manage the project
├── ollama/                # Directory for Ollama-specific tasks
├── docker-compose.yml     # Docker Compose configuration
└── README.md              # This README file
```

## How the Makefile Works
The Makefile automatically detects the operating system and adjusts settings for Docker and server hostnames. It uses the uname command for OS detection and performs the following checks:

- Linux: Sets Docker's localhost to localhost and the server host to 127.0.0.1.
- macOS: Uses docker.for.mac.localhost and tries to determine the correct server IP, falling back to 127.0.0.1 if no valid IP is found.
- Windows: Uses localhost for both Docker and server host configurations.

## Key Commands
- `make all`: Starts the AI environment and runs the necessary Docker containers.
- `make ollama serve`: Starts the Ollama AI service.
- `make ollama stop`: Stops the Ollama AI service.
- `make clean`: Cleans up the environment by stopping all Docker containers.
- `make re`: Rebuilds the entire environment from scratch.

## Contributing
If you'd like to contribute to this project, feel free to submit a pull request or open an issue to discuss your ideas. We're always looking to expand and improve the toolset for exploring open-source AI tools.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
