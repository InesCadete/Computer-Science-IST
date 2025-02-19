package xxl.core;

import xxl.core.exception.EmptyCellException;
import xxl.core.exception.StringNotIntegerException;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

public class Coalesce extends IntervalFunction implements Serializable {
    @Serial
    private static final long serialVersionUID = 202308312359L;
    public Coalesce(Range range) {
        super(range, "COALESCE");
    }
    @Override
    protected Literal compute(){
        List<Cell> auxList= this.getCells();
        for(Cell c : auxList) {
            try {
                if (!(c.getContent()==null)){
                    c.value().asInt();
                }
            }
            catch (EmptyCellException e) { continue;}
            catch(StringNotIntegerException e) {
                try { return c.value(); }
                catch (EmptyCellException ei) { continue; }
            }
        }
        return new LiteralString("'");
    }
    @Override
    Coalesce copyContent() {
        return new Coalesce(this.getRange());
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