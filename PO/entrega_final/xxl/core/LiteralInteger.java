package xxl.core;

import xxl.core.exception.IntegerNotStringException;
import xxl.core.exception.StringNotIntegerException;

import java.io.Serial;
import java.io.Serializable;

public class LiteralInteger extends Literal implements Serializable, Visited {
    @Serial
    private static final long serialVersionUID = 202308312359L;
    private int _value;
    public LiteralInteger() {
        _value = -1;
    }
    public LiteralInteger(int i) {
        _value = i;
    }
    @Override
    public String toString() {
        return Integer.toString(_value);
    }
    @Override
    public String asString() throws IntegerNotStringException {
        throw new IntegerNotStringException();
    }
    @Override
    public int asInt() {
        return _value;
    }

    public void setValue(int value) {
        _value = value;
    }
    @Override
    LiteralInteger copyContent() {
        return new LiteralInteger(_value);
    }

    @Override
    public boolean equals(Object object) {
        if(this == object) {
            return true;
        }
        if(object == null || getClass() != object.getClass()) {
            return false;
        }
        LiteralInteger literalInteger = (LiteralInteger) object;

        return _value == literalInteger.asInt();
    }
    @Override
    public String accept(Visitor v) {
        return v.visitLiteralInteger(this);
    }
}
