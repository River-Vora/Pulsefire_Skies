# Eternal Conflict

Eternal Conflict is a macOS game built using Swift and SceneKit. Take control of a spaceship and navigate dynamic 3D environments. This project serves as an excellent foundation for aspiring developers interested in game development with SceneKit on macOS.

## Features

- **Immersive 3D Gameplay**: Control a spaceship in a visually engaging 3D world.
- **Keyboard Controls**: Intuitive controls for movement and navigation.
- **SceneKit Integration**: Utilizes SceneKit for rendering and game mechanics.
- **Cross-Platform Logic**: Shared game logic that can be adapted for other platforms.

## Getting Started

### Prerequisites

Ensure you have the following installed:

- [Xcode](https://developer.apple.com/xcode/) 16.0 or later
- macOS Sequoia (15.0) or later
- Basic understanding of Swift and SceneKit

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/River-Vora/Pulsefire_Skies.git
   ```
2. Open the project in Xcode:
   ```bash
   cd Pulsefire_Skies
   open Pulsefire_Skies.xcodeproj
   ```
3. Build and run the project:
   - Select the `XenoStrike macOS` target.
   - Click the **Run** button in Xcode to launch the game.

## Controls

- **W (13)**: Move forward
- **S (1)**: Move backward
- **A (0)**: Rotate left
- **D (2)**: Rotate right

## Project Structure

- `XenoStrike macOS`: macOS-specific files, including the main app delegate and view controller.
- `XenoStrike Shared`: Shared game logic, including the `GameController` class.
- `Art.scnassets`: 3D assets used in the game.

## Known Issues

- Movement doesn't fully work and is still a work-in-progress.
- The ground scene currently does not load any child nodes (`Ground scene loaded with 0 child nodes`).

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add a new feature"
   ```
4. Push to your fork:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.

---

### Author

Developed and maintained by [River Vora](https://github.com/River-Vora).
