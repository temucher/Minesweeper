//Teagan Mucher, Block 4 AP CS

//General debugging issues, as well as some method problems

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList();
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    //declare and initialize buttons
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int i = 0; i<NUM_ROWS; i++) {
        for(int z = 0; z<NUM_COLS; z++) {
            buttons[i][z] = new MSButton(i, z);
        }
    }
    for(int i = 0; i<=40; i++){
        setBombs();
    }
}
public void setBombs()
{
    int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);
    if(!bombs.contains(buttons[row][col])) {
        bombs.add(buttons[row][col]);
    }
}

public void draw ()
{
    if(isWon()) {
    background( 0 );
        displayWinningMessage();
    }
    else {
        for(int i = 0; i<bombs.size(); i++) {
            if(bombs.get(i).isClicked()==true) {
                displayLosingMessage();
            }
        }
    }
}
public boolean isWon()
{
    boolean response = false;
    for(int i = 0; i<NUM_COLS; i++) {
        for(int z = 0; z<NUM_ROWS; z++) {
            if(buttons[i][z].clicked) {
                if(i==NUM_COLS-1 && z==NUM_ROWS-1) {
                    response = true;
                }
            }
            else {
                response = false;
            }    
        }

    }
    return response;
}
public void displayLosingMessage()
{
    String loseMsg = "You suck";
    for(int i = 1; i<=8; i++) {
        buttons[10][5+i].setLabel(loseMsg.substring(i-1,i));
    }
}
public void displayWinningMessage()
{    
    String winMsg = "Congrats";
    for(int i =1; i<=8; i++) {
        buttons[10][5+i].setLabel(winMsg.substring(i-1,i));
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed) {
            marked = !marked;
        }
        else if(bombs.contains(this)) {
            displayLosingMessage();
        }
        else if(this.countBombs(r,c)>0) {
            label = Integer.toString(countBombs(r,c));
        }
        else {
            if((isValid(r-1,c-1)) && (buttons[r-1][c-1].clicked == false)) {buttons[r-1][c-1].mousePressed();}
            if((isValid(r,c-1)) && (buttons[r][c-1].clicked == false)) {buttons[r][c-1].mousePressed();}
            if((isValid(r+1,c-1)) && (buttons[r+1][c-1].clicked == false)) {buttons[r+1][c-1].mousePressed();}
            if((isValid(r-1,c)) && (buttons[r-1][c].clicked == false)) {buttons[r-1][c].mousePressed();}
            if((isValid(r+1,c)) && (buttons[r+1][c].clicked == false)) {buttons[r+1][c].mousePressed();}
            if((isValid(r-1,c+1)) && (buttons[r-1][c+1].clicked == false)) {buttons[r-1][c+1].mousePressed();}
            if((isValid(r,c+1)) && (buttons[r][c+1].clicked == false)) {buttons[r][c+1].mousePressed();}
            if((isValid(r+1,c+1)) && (buttons[r+1][c+1].clicked == false)) {buttons[r+1][c+1].mousePressed();}
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }

    public boolean isValid(int r, int c)
    {
        return ((r<20 && c<20) && (r>=0 && c>=0));
    }

    public int countBombs(int r, int c)
    {
        int numBombs = 0;
        if(isValid(r-1,c-1) && bombs.contains(buttons[r-1][c-1])) {numBombs++;}
        if(isValid(r-1,c) && bombs.contains(buttons[r-1][c])) {numBombs++;}
        if(isValid(r-1,c+1) && bombs.contains(buttons[r-1][c+1])) {numBombs++;}
        if(isValid(r,c-1) && bombs.contains(buttons[r][c-1])) {numBombs++;}
        if(isValid(r,c+1) && bombs.contains(buttons[r][c+1])) {numBombs++;}
        if(isValid(r+1,c-1) && bombs.contains(buttons[r+1][c-1])) {numBombs++;}
        if(isValid(r+1,c) && bombs.contains(buttons[r+1][c])) {numBombs++;}
        if(isValid(r+1,c+1) && bombs.contains(buttons[r+1][c+1])) {numBombs++;}
        return numBombs;
    }
}
