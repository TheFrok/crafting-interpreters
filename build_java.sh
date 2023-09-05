javac -cp java -d build java/com/craftinginterpreters/tool/*java  && \
java -cp build com.craftinginterpreters.tool.GenerateAst java/com/craftinginterpreters/lox  && \
javac -cp java -d build java/com/craftinginterpreters/lox/*java 
read -n 1 -p "Build Done! press [Enter]"

