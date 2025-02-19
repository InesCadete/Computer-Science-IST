package xxl.core;

import xxl.core.exception.EmptyCellException;
import xxl.core.exception.StringNotIntegerException;

import java.io.Serial;
import java.io.Serializable;

public class Div extends BinaryFunction implements Serializable {
    @Serial
    private static final long serialVersionUID = 202308312359L;
    public Div(Content one, Content two) {
        super("DIV", one, two);
    }
    @Override
    protected Literal compute() {
        LiteralInteger result = new LiteralInteger();
        try { int r = this.getFirstContent().value().asInt() / this.getSecondContent().value().asInt();
            result.setValue(r);
        } catch (StringNotIntegerException | EmptyCellException e) {
            return new LiteralString("#VALUE");
        }
        return result;
    }
    @Override
    Div copyContent() {
        return new Div(this.getFirstContent(), this.getSecondContent());
    }
}
