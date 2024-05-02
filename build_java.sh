javac -cp java -d build java/com/craftinginterpreters/tool/*java  && \
java -cp build com.craftinginterpreters.tool.GenerateAst java/com/craftinginterpreters/lox  && \
javac -cp java -d build java/com/craftinginterpreters/lox/*java && \
jar --create --file Lox.jar --main-class com.craftinginterpreters.lox.Lox -C build/ .
read -n 1 -p "Build Done! press [Enter]"

