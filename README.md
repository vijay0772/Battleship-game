1. Overview:

For this project, I developed an application that interfaces with an existing RESTful service, allowing users to register, log in, and play games of Battleships against both human and computer opponents.

The primary objective of this project was to provide an opportunity to integrate a RESTful API into a Flutter application. To achieve this, I carefully studied the provided REST API documentation and utilized asynchronous operations, powered by the http package, to communicate effectively with the API.

2. Specifications:

I have also created a demo of the running application that fulfills all the requirements, which can be viewed at https://youtu.be/0oMGXxXpp04?si=ZaUBT2EZMU6Zrxif.

Below, I provide an overview of the features, followed by detailed behavioral specifications and implementation-level details of the work I completed. In the next section, I provide comprehensive documentation for the RESTful API.

2.1 Feature overview:

Here are the high-level features that I implemented in the final application:

User authentication, including login and registration functionality.
Session management, ensuring session tokens are stored across application restarts and prompting users to log in again when their tokens expire.
Displaying a list of ongoing and completed Battleships games played by the user.
Enabling users to play Battleships against both human and AI opponents.
2.2 Behavioral specifications
2.2.1 Login and Registration
The login screen allows users to enter their username and password to access the application. If a user does not have an account, they can register for a new one directly from this screen. After a successful login or registration, the session token returned by the server is stored locally and is used to authenticate all subsequent requests to the server. If the session token expires, the user is required to log in again.

2.2.2 Game List:

The game list page, by default, displays a list of all games in either the matchmaking or active state. I added a manual refresh button to allow users to update the list of games. Each game in the list shows the following details:

The game ID:

The usernames of both players if the game has already started
The current game status (matchmaking, lost, won, user's turn, opponent's turn)
The game list page also includes a menu that provides the following options:

Start a new game with a human opponent
Start a new game with an AI opponent
Toggle between showing active and completed games
Log out
Both completed and active game items are tappable, leading the user to the game view page, where they can view the game board and play their turn if it's their turn.

Active games and those in the matchmaking phase can also be deleted, which automatically forfeits them on the server. I provided a deletion mechanism that can be initiated by either a dedicated button or a swipe-to-delete action.

2.2.3 New Game:

When starting a new game, users are prompted to place their ships on a 5x5 game board. Each ship occupies a single tile, and the user must place 5 ships to start the game. The grid is clearly labeled with row letters (A to E) and column numbers (1 to 5).

I designed the board so that users can place ships by tapping on the board and remove ships by tapping on them again. The game logic prevents users from placing ships on top of each other or outside the board boundaries. Once all 5 ships are placed, the game is started, and the ship placements are submitted to the server. The user is then redirected to the game list page, which displays the new game in the list of active games.

2.2.4 Playing a Game:

The game view page displays the game board, allowing users to play their turns if it is their turn. The board visually displays the following information:

The locations of the user's ships
The locations where the user's ships have been hit by the opponent
The locations of the user's shots that missed
The locations of the user's shots that hit an enemy ship
I ensured that this information is displayed clearly, allowing the user to easily distinguish between different types of data.

If it's the user's turn, they can play a shot by tapping on the board to select a location and then submitting it. The board updates to reflect whether the shot hit an enemy ship or missed, and if the shot wins the game, the user is notified of their victory.

In human vs. human games, users cannot play another shot until their opponent has played, which may require them to return to the game list page and refresh it to see the updated game status.

In human vs. AI games, after the user plays a shot, the AI immediately updates the game state, allowing the user to continue playing until the game is won or lost.

2.2.5 Responsiveness:

I made the app responsive to changes in screen size, ensuring that the entire 5x5 grid scales up to take advantage of larger screens without being cropped or clipped. On larger screens, the game list and gameplay views may be displayed side-by-side, though this is an optional feature.

2.3 Implementation requirements

2.3.1 External packages

I included the following packages in the pubspec.yaml file:

http: Provides high-level asynchronous functions for communicating with HTTP servers.
shared_preferences: Offers a persistent store for simple data, allowing session tokens to be stored locally.
provider: Provides utilities for managing and disseminating stateful data.
No additional packages were added without prior consultation.

2.3.2 Code structure and organization:

I modularized the UI code to ensure it's easy to read and maintain. I created separate widgets for each of the main pages described above and further modularized the code into smaller widgets where necessary (e.g., for representing individual game items or the game board).

I avoided using global variables or functions. All data is encapsulated within model classes, and state management is handled through a combination of techniques discussed during the project.

Major widget classes are organized in their own files within the "lib/views" directory, model classes in "lib/models", and helper classes in "lib/utils". Additional directories were created as needed to keep the codebase well-organized.

2.3.3 Managing asynchronous operations:

I ensured that the UI remains responsive while performing asynchronous operations. This includes database operations, which are performed asynchronously. I used FutureProvider, FutureBuilder, and StreamBuilder to manage these operations and displayed a loading indicator during lengthy processes to enhance the user experience.

3. Battleships REST API
The Battleships REST API service can be accessed at the base URL http://165.227.117.48. Below is the detailed documentation of the API routes I integrated into the application:

3.1 Authentication:

POST base-URL/register: This route registers a new user. The JSON request body contains the following fields:

username: The new user's username.
password: The new user's password.
Both fields must be at least 3 characters long and cannot contain spaces. If the username is available, the server responds with a JSON object containing:

message: Confirmation that the user was successfully created.
access_token: The user's access token, which must be included in subsequent API requests. Tokens expire after 1 hour, requiring re-login for renewal.
POST base-URL/login: This route logs in an existing user. The JSON request body contains:

username: The user's username.
password: The user's password.
If the credentials are correct, the server responds with a JSON object containing:

message: Confirmation that the user was successfully logged in.
access_token: The user's access token, used for subsequent API requests. Tokens expire after 1 hour and require re-login for renewal.
3.2 Managing Games:

For all routes in this section, the HTTP request header must include the Authorization field with the value "Bearer <access_token>", where <access_token> is the user's access token returned by the server during login. If the token is missing or invalid, the server responds with a 401 Unauthorized error, requiring re-login.

Successful operations result in an HTTP status code of 200.

GET base-URL/games: Retrieves all active and completed games for the logged-in user.

The server responds with a JSON object containing a games field, which is a list of JSON objects representing each game. Each game object contains:

id: The game's unique ID.
player1: The username of player 1.
player2: The username of player 2.
position: The user's position in the game (1 or 2).
status: The game's status:
0: Matchmaking phase.
1: Player 1 won.
2: Player 2 won.
3: Game is ongoing.
turn: The position of the player whose turn it is (1 or 2); if the game is inactive, the value is 0.
POST base-URL/games: Starts a new game with specified ship placements. The JSON request body contains:

ships: A list of 5 unique ship locations, each as a string in the format "<row><col>", where <row> is between A and E and <col> is between 1 and 5. For example, "A1" represents the top-left corner, and "E5" represents the bottom-right corner of the board.
ai (optional): Specifies the AI opponent's type—either "random", "perfect", or "oneship". If omitted, the server matches the user with another human player.
Example request bodies:

{ "ships": ["A1", "A2", "A3", "A4", "A5"] }
{ "ships": ["B1", "A2", "D3", "C4", "E5"], "ai": "random" }
Upon success, the server responds with a JSON object containing:

id: The unique ID of the game.
player: The user's position in the game (1 or 2).
matched: True if the user was matched with an opponent, False if waiting for a human opponent.
GET base-URL/games/<game_id>: Retrieves detailed information about a specific game with ID <game_id>. The server responds with a JSON object containing:

id: The game's unique ID.
status: The game's current status:
0: Matchmaking phase.
1: Player 1 won.
2: Player 2 won.
3: Game is ongoing.
position: The user's position in the game (1 or 2).
turn: The position of the player whose turn it is (1 or 2); 0 if the game is inactive.
player1: The username of player 1.
player2: The username of player 2.
ships: List of the user's remaining ship coordinates.
wrecks: List of the user's wrecked ship coordinates.
shots: List of the user's missed shot coordinates.
sunk: List of the user's shots that successfully hit an enemy ship.
PUT base-URL/games/<game_id>: Plays a shot in the game with ID <game_id>. The JSON request body contains:

shot: A string representing the shot's location in the format "<row><col>", where <row> is between A and E and <col> is between 1 and 5.
Upon success, the server responds with a JSON object containing:

message: Confirmation that the shot was successfully played.
sunk_ship: True if the shot hit an enemy ship, False otherwise.
won: True if the shot won the game for the user, False otherwise.
DELETE base-URL/games/<game_id>: Cancels or forfeits the game with ID <game_id>. Only games currently in the matchmaking or active state can be canceled or forfeited. The server responds with a JSON object containing:

message: Confirmation that the game was successfully canceled or forfeited.
