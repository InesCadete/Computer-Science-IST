package xxl.core;

import java.io.Serial;
import java.io.Serializable;

public class VisitorName implements Serializable, Visitor{
    @Serial
    private static final long serialVersionUID = 202308312359L;
    @Override
    public String visitReference(Reference reference) {
        return "Reference";
    }

    @Override
    public String visitLiteralString(LiteralString literalString) {
        return "LiteralString";
    }

    @Override
    public String visitLiteralInteger(LiteralInteger literalInteger) {
        return "LiteralInteger";
    }

    @Override
    public String visitFunction(Function function) {
        return "Function";
    }
}
