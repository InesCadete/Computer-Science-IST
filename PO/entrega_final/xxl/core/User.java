package xxl.core;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

public class User {
    // Attributes:
    private final String _name;
    private ArrayList<Spreadsheet> _spreadSheets = new ArrayList<>();
    private int _spreadSheetCounter;

    // Constructor:
    public User(String name) {
        _name = name;
    }

    public Spreadsheet getSpreadSheet(int index) {
        if (index >= 0 && index < _spreadSheetCounter)
            return _spreadSheets.get(index);
        return null;
    }

    public void addSpreadSheet(Spreadsheet sheet) {
        _spreadSheets.add(sheet);
    }
    public void removeSpreadSheet(Spreadsheet sheet) {_spreadSheets.remove(sheet); }

    public final String getName() {
        return _name;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        User other = (User) obj;
        return Objects.equals(_name, other._name);
    }
    @Override
    public int hashCode() {
        return Objects.hash(_name);
    }

    public List<Spreadsheet> getSpreadsheet() { return Collections.unmodifiableList(_spreadSheets);}

}
