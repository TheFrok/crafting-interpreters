package com.craftinginterpreters.lox;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Stack;

class Resolver implements Expr.Visitor<Void>,
        Stmt.Visitor<Void> {
    Interpreter interpreter;
    HashMap<Token, Integer> resolutions;
    Stack<HashSet<String>> envs;

    Resolver(Interpreter interpreter) {
        this.interpreter = interpreter;
        this.resolutions = new HashMap<>();
        this.envs = new Stack<>();
    }

    public Void visitBlockStmt(Stmt.Block block) {
        envs.push(new HashSet());
        for (Stmt stmt : block.statements) {
            resolveStmt(stmt);
        }
        envs.pop();
    }

    public Void visitVariableExpr(Expr.Variable variable) {
        if (envs.empty()) {
            return;
        }
        for (int i = envs.size(); i >= 0; i--) {
            HashSet env = this.envs.get(i);
            if (env.contains(variable.name.lexeme)) {
                this.resolutions.put(variable.name.lexeme, envs.size() - i)
            }
        }
    }

    public Void visitAssignExpr(Expr.Assign assign) {
        if (this.envs.empty()) {
            return;
        }
        this.resolveExpr(assign.value);
        this.envs.peek().add(assign.name);
    }

    public Void resolveStmt(Stmt stmt) {
        stmt.accept(this);
    }

    public Void resolveExpr(Expr expr) {
        expr.accept(this)
    }

}
