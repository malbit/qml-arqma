qml-arqma
==============

Development environment for QML/JS with a mock Qt application that resembles the Arqma GUI.

![](https://i.imgur.com/YnbWvwI.png)

Solves the problem of having to wait on arqma-gui compiles to see your latest QML/JS changes.

Included in this repository are:

- `qml-xmr` - Fork of [qml-livereload](https://github.com/penk/qml-livereload). Injects arqma-gui related context.
- An example Qt application that uses Arqma(Monero) components.

The recommended way is to use the Sublime Text 3 to edit `app/Mock.qml`, then compile it via a custom Sublime build system.

### Requirements:

- Sublime Text 3 or any other IDE
- Qt 5.7
- CMake >= 3.10

```
qmake --version
QMake version 3.0
Using Qt version 5.7.1 in /home/dsc/Qt/5.7/gcc_64/lib
```

Make sure to correctly set your environment. Consult `qtchooser -print-env`

### Installation


First compile `qml-arqma`:

```
cd qml-arqma
cmake . && make && sudo make install
```

Or if you prefer `qmake`:


```
cd qml-arqma
qmake
sudo make
```

Compiled binary will be found at `/usr/local/bin/qml-arqma`.

Update the `arqma-gui` submodule:

```
git submodule init
git submodule update
```

Launch Sublime Text 3 and make a new build system:

1. Open the file `app/Mock.qml`
2. Go to `Tools->Build System->New Build System`
3. Paste the following:

```javascript
{
    "shell_cmd": "qml-arqma $file_path/monero-gui.qml"
}
```

4. Save the file as `qml-arqma.sublime-build`
5. Go to `Tools->Build System` and select `qml-arqma`

Modify `Mock.qml` as you please. Press `CTRL-B` to run the application.

### Tips

- `arqma-gui.qml` is the entry point of the application, you shouldn't need to edit it. It includes `Mock.qml` automatically.
- Update the submodule `arqma-gui` regularly
