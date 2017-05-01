This project is bootstrapped with [Create Elm App](https://github.com/halfzebra/create-elm-app).

## Installing

```sh
elm-package install
cp src/Config.elm.example src/Config.elm
```

## Folder structure

- `src/index.html` is the page template;
- `src/index.js` is the JavaScript entry point.

## Available scripts
In the project directory you can run:
### `elm-app build`
Builds the app for production to the `dist` folder.

The build is minified, and the filenames include the hashes.
Your app is ready to be deployed!

### `elm-app start`
Runs the app in the development mode.
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.
You will also see any lint errors in the console.

### `elm-app test`
Run tests with [node-test-runner](https://github.com/rtfeldman/node-test-runner/tree/master)

You can make test runner watch project files by running:
```sh
elm-app test --watch
```

### `elm-app eject`
**Note: this is a one-way operation. Once you `eject`, you can’t go back!**

If you aren’t satisfied with the build tool and configuration choices, you can `eject` at any time.

Instead, it will copy all the configuration files and the transitive dependencies (Webpack, Elm Platform, etc.) right into your project, so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point, you’re on your own.

You don’t have to use 'eject' The curated feature set is suitable for small and middle deployments, and you shouldn’t feel obligated to use this feature. However, we understand that this tool wouldn’t be useful if you couldn’t customize it when you are ready for it.

### `elm-app <elm-platform-comand>`
Create Elm App does not rely on the global installation of Elm Platform, but you still can use it's local Elm Platform to access default command line tools:

#### `package`
Alias for [elm-package](http://guide.elm-lang.org/get_started.html#elm-package)

Use it for installing Elm packages from [package.elm-lang.org](http://package.elm-lang.org/)

#### `repl`
Alias for [elm-repl](http://guide.elm-lang.org/get_started.html#elm-repl)

#### `make`
Alias for  [elm-make](http://guide.elm-lang.org/get_started.html#elm-make)

#### `reactor`
Alias for  [elm-reactor](http://guide.elm-lang.org/get_started.html#elm-reactor)

## Adding Images and Fonts

With Webpack, using static assets like images and fonts works similarly to CSS.

By requiring an image in JavaScript code, you tell Webpack to add a file to the build of your application. The variable will contain a unique path to the said file.

Here is an example:

```js
require('./main.css');
var logoPath = require('./logo.svg'); // Tell Webpack this JS file uses this image
var Elm = require('./App.elm');

var root = document.getElementById('root');

Elm.App.embed(root, logoPath); // Pass image path as a flag.
```
Later on, you can use the image path in your view for displaying it in the DOM.

```elm
view : Model -> Html Msg
view model =
    div []
        [ img [ src model.logo ] []
        , div [] [ text model.message ]
        ]
```

## Deploying to GitHub Pages

#### Step 1: install [gh-pages](https://github.com/tschaub/gh-pages)
```sh
npm install gh-pages -g
```

#### Step 2: configure `SERVED_PATH` environment variable
Create a `.env` file in the root of your project to specify the `SERVED_PATH` environment variable.

```
SERVED_PATH=./
```

The path must be `./` so the assets are served using relative paths.

#### Step 3: build the project and deploy it to GitHub Pages
```sh
elm-app build
gh-pages -d dist
```
