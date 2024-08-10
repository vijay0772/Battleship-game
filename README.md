# Battleships Game

## Inspiration

The inspiration behind this project was to create an engaging and interactive gaming experience that allows users to enjoy the classic game of Battleships in a modern, digital format. The goal was to integrate a RESTful API into a Flutter application, providing users with the ability to play against both human and AI opponents, while also gaining experience with managing asynchronous operations, state management, and responsive UI design.

## What It Does

The application allows users to:
- Register and log in.
- Play games of Battleships against either human or computer opponents.
- View a list of ongoing and completed games.
- Start new games.
- Place ships on a game board.
- Play their turns by selecting shot locations on the board.

The app ensures that gameplay is smooth and responsive, providing feedback for each action, such as hit, miss, or win. It also supports session management with tokens for secure user authentication.

## How We Built It

The application was built using:
- **Flutter**: For the frontend, providing a responsive and visually appealing user interface.
- **http package**: To handle asynchronous communication with the RESTful API.
- **shared_preferences package**: To manage session tokens locally.
- **provider package**: For state management, keeping the UI in sync with the game state.
- **RESTful API**: For user registration, login, game creation, and gameplay.

## Challenges We Ran Into

- Ensuring the application remained responsive during asynchronous operations, such as retrieving game data from the server or submitting moves.
- Managing the game state across different screens and ensuring that the UI reflected the latest game status, especially in human vs. AI games.
- Implementing a clean and modular code structure adhering to best practices for Flutter development.

## Accomplishments That We're Proud Of

- Successfully integrating the RESTful API into the Flutter application, providing a seamless experience for users.
- Creating a responsive design for the game board that adapts to different screen sizes.
- Efficiently handling session management, ensuring secure storage of user tokens and prompt login prompts when needed.

## What We Learned

- Working with RESTful APIs and handling asynchronous operations in Flutter.
- Managing application state using the provider package.
- Designing a responsive UI that works well across different devices.
- Structuring a Flutter project in a modular and maintainable way.

## What's Next for The Haunted Manor

- Enhance the AI opponents to provide a more challenging gameplay experience, possibly incorporating different levels of difficulty.
- Add more features, such as multiplayer support with real-time updates, improved animations for ship placement and shots, and additional game modes.
- Expand the application to support online multiplayer with matchmaking and chat functionality.

## Built With

- **Flutter**: For building the frontend and creating a responsive UI.
- **http package**: To manage HTTP requests and handle asynchronous operations with the RESTful API.
- **shared_preferences package**: For storing session tokens locally and managing user sessions.
- **provider package**: To handle state management and ensure that the UI stays in sync with the game state.
- **RESTful API**: To handle user authentication, game creation, and gameplay logic on the server side.
