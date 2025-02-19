package xxl.core;

import xxl.core.exception.EmptyCellException;
import xxl.core.exception.IntegerNotStringException;
import xxl.core.exception.StringNotIntegerException;

import java.io.Serial;
import java.io.Serializable;

public abstract class Literal extends Content implements Serializable {
    @Serial
    private static final long serialVersionUID = 202308312359L;

    @Override
    Literal value() {
        return this;
    }

    @Override
    public abstract String asString() throws IntegerNotStringException;

    @Override
    public abstract int asInt() throws StringNotIntegerException;

    @Override
    abstract Literal copyContent();


}