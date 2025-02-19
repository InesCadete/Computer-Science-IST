package xxl.core;

import xxl.core.exception.EmptyCellException;
import xxl.core.exception.IntegerNotStringException;
import xxl.core.exception.StringNotIntegerException;

import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Cell implements Serializable, ObservedCell {
    @Serial
    private static final long serialVersionUID = 202308312359L;
    private final int _row;
    private final int _column;
    private Content _content;

    // list of cell observers to notify when changes are made
    List<CellObserver> _observers;


    /**
     * Constructor: Creates and instance of the 'User' class
     *              and associates it with only its position
     *
     *  @param row row of the cell
     *  @param column column of the cell
     */
    public Cell(int row, int column) {
        _row = row;
        _column = column;
        _observers = new ArrayList<>();
    }

    /**
     * Constructor: Creates and instance of the 'Cell' class
     *              and associates it with its position and content
     *
     * @param row row of the cell
     * @param column column of the cell
     * @param content content of the cell
     */
    public Cell(int row, int column, Content content) {
        _row = row;
        _column = column;
        _content = content;
        _observers = new ArrayList<>();

    }
    public int getRow() {
        return _row;
    }

    public int getColumn() {
        return _column;
    }


    /**
     * Format of string that shows the information about the cell, regarding
     * its position and content
     *
     * @return string with all the cells' information
     */
    @Override
    public String toString() {
        if (_content == null)
            return _row+";"+_column+"|";
        return _row+";"+_column+"|"+_content.toString();
    }

    /**
     * Creates a copy of the content of a cell
     *
     * @throws EmptyCellException in case the content of the cell being copied is null
     * @return a copy of the content of the cell
     */
    Content copyContent() throws EmptyCellException {
        if (_content == null)
            throw new EmptyCellException();
        return _content.copyContent();
    }

    /**
     * Changes the content of a cell
     */
    void setContent(Content content) {
        this.notifyCellObserver();
        _content = content;
    }

    /**
     * Provides the content of a cell
     *
     * @throws EmptyCellException in case the content of the cell being copied is null
     * @return content of the cell
     */
    Content getContent() throws EmptyCellException {
        if(_content == null) {
            throw new EmptyCellException();
        }
        return _content;
    }

    /**
     * Provides the value of a cell, which is in its content
     *
     * @throws EmptyCellException in case the content of the cell being copied is null
     * @return the Literal value of a cell
     */
    Literal value() throws EmptyCellException {
        if (_content == null)
            throw new EmptyCellException();
        return _content.value();
    }

    /**
     * Provides the value of a cell as an integer
     *
     * @throws EmptyCellException in case the content of the cell being copied is null
     * @throws StringNotIntegerException in case it is a string and not an integer
     * @return the value of the cell as an int
     */
    public int asInt() throws StringNotIntegerException, EmptyCellException {
        return _content.value().asInt();
    }

    /**
     * Provides the value of a cell as a String
     *
     * @throws EmptyCellException in case the content of the cell being copied is null
     * @throws IntegerNotStringException in case it is a string and not an integer
     * @return the value of the cell as an int
     */

    public String asString() throws IntegerNotStringException, EmptyCellException {
        return _content.value().asString();
    }


    /**
     * Adds a cell observer
     *
     * @param o observer to be added
     *
     */
    public void registerCellObserver(CellObserver o) {
        _observers.add(o);
    }

    /**
     * Removes a cell observer
     *
     * @param o observer to be removed
     *
     */
    public void removeCellObserver(CellObserver o) {
        int observerIndex = _observers.indexOf(o);
        if (observerIndex >= 0)
            _observers.remove(observerIndex);
    }
    /**
     * Notifies a cell observer
     *
     */
    public void notifyCellObserver() {
        _observers.forEach(CellObserver::update);
    }
}
