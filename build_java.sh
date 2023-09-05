javac -cp java -d build java/com/craftinginterpreters/tool/*java || exit
java -cp build com.craftinginterpreters.tool.GenerateAst java/com/craftinginterpreters/lox || exit
javac -cp java -d build java/com/craftinginterpreters/lox/*java || exit
echo "Build Done!"
