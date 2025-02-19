package xxl.core;

import xxl.core.exception.EmptyCellException;
import xxl.core.exception.IntegerNotStringException;
import xxl.core.exception.StringNotIntegerException;

import java.io.Serial;
import java.io.Serializable;

public abstract class Content implements Serializable, Visited {
    @Serial
    private static final long serialVersionUID = 202308312359L;
    public abstract String accept(Visitor v);
    abstract Content copyContent();
    @Override
    public abstract String toString();
    abstract Literal value() throws EmptyCellException;
    public String asString() throws IntegerNotStringException, EmptyCellException {
        return value().asString();
    }
    public  int asInt() throws StringNotIntegerException, EmptyCellException {
        return value().asInt();
    }
}
