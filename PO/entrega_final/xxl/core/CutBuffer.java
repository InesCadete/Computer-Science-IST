package xxl.core;

import xxl.core.exception.EmptyCellException;

import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class CutBuffer  implements Serializable {
    @Serial
    private static final long serialVersionUID = 202308312359L;
    private List<Cell> _cells;
    private boolean _horizontal;
    private int _counter;

    //AAA
    public boolean getHorizontal() {
        return _horizontal;
    }
    int getSize() {
        return _cells.size();
    }

    public CutBuffer() {
        _cells = new ArrayList<>();
    }

    public List<Cell> getCells() {
        return _cells;
    }

    public void copyRangeToCutBuffer(Range range) {
        int rowCutBuffer = 1;
        int columnCutBuffer = 1;
        Content contentCopy;

        _cells.clear(); // Cleans cutBuffer;
        _horizontal = range.getHorizontal();


        for (Cell cell : range.getCells()) {
            // creates an independent copy of the cell content
            try { contentCopy = cell.copyContent(); }
            catch (EmptyCellException e) {
                contentCopy = null;
            }

            // inserts the copy in a new Cell, with the CutBuffer position
            Cell cellCopy = new Cell(rowCutBuffer, columnCutBuffer, contentCopy);

            // advances on the rows and columns of CutBuffer
            if (range.getHorizontal()) {
                columnCutBuffer++;
            } else {
                rowCutBuffer++;
            }
            // adds the Cell to CutBuffer
            _cells.add(cellCopy);
        }
    }
}
