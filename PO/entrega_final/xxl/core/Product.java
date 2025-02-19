package xxl.core;

import xxl.core.exception.EmptyCellException;
import xxl.core.exception.StringNotIntegerException;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

public class Product extends IntervalFunction implements Serializable {
    @Serial
    private static final long serialVersionUID = 202308312359L;
    public Product(Range range) {
        super(range, "PRODUCT");
    }
    @Override
    protected Literal compute(){;
        int aux = 1;
        List<Cell> auxList= this.getCells();
        for(Cell c : auxList) {
            try {
                aux *= (c.value().asInt());
            }
            catch(StringNotIntegerException | EmptyCellException e) {
                return new LiteralString("#VALUE");
            }
        }
        return new LiteralInteger(aux);
    }
    @Override
    Product copyContent() {
        return new Product(this.getRange());
    }
    @Override
    public Range getRange() {
        return super.getRange();
    }
    @Override
    public List<Cell> getCells() {
        return super.getRange().getCells();
    }
}