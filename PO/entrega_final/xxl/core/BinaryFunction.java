package xxl.core;

import xxl.core.exception.EmptyCellException;

import java.io.Serial;
import java.io.Serializable;

public abstract class BinaryFunction extends Function implements Serializable, CellObserver {
    @Serial
    private static final long serialVersionUID = 202308312359L;
    private final Content _firstContent;
    private final Content _secondContent;
    public BinaryFunction(String name, Content one, Content two) {
        super(name);
        _firstContent = one;
        _secondContent = two;
        Visitor v = new VisitorName();
        if (_firstContent.accept(v).equals("Reference")) {
            Reference ref1 = (Reference) _firstContent;
            ref1.getSpreadSheet().getCell(ref1.getRow(), ref1.getColumn()).registerCellObserver(this);
        }
        if (_secondContent.accept(v).equals("Reference")) {
            Reference ref2 = (Reference) _secondContent;
            ref2.getSpreadSheet().getCell(ref2.getRow(), ref2.getColumn()).registerCellObserver(this);
        }
        this.setValue(this.compute());
    }
    public Content getFirstContent() {
        return _firstContent;
    }
    public Content getSecondContent() {
        return _secondContent;
    }
    @Override
    public String toString() {
        this.compute();
        String content1 = _firstContent.toString();
        String content1Trim;
        String content2 = _secondContent.toString();
        String content2Trim;
        int index = content1.indexOf('=');
        if (index != -1)
            content1Trim = content1.substring(index + 1);
        else
            content1Trim = content1;
        index = content2.indexOf('=');
        if (index != -1)
            content2Trim = content2.substring(index + 1);
        else
            content2Trim = content2;
        try {
            return this.value().toString() + "=" + this.getName() + "(" + content1Trim + "," + content2Trim + ")";
        } catch (EmptyCellException e) {
            return "#VALUE=" + this.getName() + "(" + content1Trim + "," + content2Trim + ")";
        }
    }
    public void unsubscribe() {
        Visitor v1 = new VisitorName();
        Visitor v2 = new VisitorName();
        if (_firstContent.accept(v1).equals("Reference")) {
            Reference ref1 = (Reference) _firstContent;
            ref1.getSpreadSheet().getCell(ref1.getRow(), ref1.getColumn()).removeCellObserver(this);
        }
        if (_secondContent.accept(v2).equals("Reference")) {
            Reference ref2 = (Reference) _secondContent;
            ref2.getSpreadSheet().getCell(ref2.getRow(), ref2.getColumn()).removeCellObserver(this);
        }
    }
}