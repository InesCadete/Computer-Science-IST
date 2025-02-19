package xxl.core;

import xxl.core.exception.EmptyCellException;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

public abstract class IntervalFunction extends Function implements Serializable, CellObserver {
    @Serial
    private static final long serialVersionUID = 202308312359L;
    private Range _range;
    public IntervalFunction(Range range, String name) {
        super(name);
        _range = range;
        List<Cell> cellList = _range.getCells();
        for (Cell cell : cellList) {
            cell.registerCellObserver(this);
        }
        this.setValue(this.compute());
    }
    abstract public List<Cell> getCells();
    public Range getRange(){
        return _range;
    }
    @Override
    public String toString(){
        this.compute();
        try {
            return this.value().toString() + "=" + getName() +
                    "(" + this.getRange().getBeginRow() + ";" + this.getRange().getBeginColumn() + ":" +
                    this.getRange().getEndRow() + ";" + getRange().getEndColumn() + ")";
        }catch (EmptyCellException e) {
            return "VALUE==" + getName() +
                "(" + this.getRange().getBeginRow() + ";" + this.getRange().getBeginColumn() + ":" +
                this.getRange().getEndRow() + ";" + getRange().getEndColumn() + ")";
        }
    }
    @Override
    abstract protected Literal compute();
    public void unsubscribe() {
        List<Cell> cellList = _range.getCells();
        for (Cell cell : cellList) {
            cell.removeCellObserver(this);
        }
    }
}