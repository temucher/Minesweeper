//Teagan Mucher, Block 4 AP CS

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
    for(int i = 0; i<=20; i++){
        setBombs();
    }
}
public void setBombs()
{
    int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);
    if(!bombs.contains(buttons[row][col])) {
        bombs.add(new MSButton(row,col));
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
    else {
        displayLosingMessage();
    }
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    textAlign(CENTER);
    text("You suck",200,200);
}
public void displayWinningMessage()
{    
    textAlign(CENTER);
    text("You are ok i guess",200,200);
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
        else if(countBombs(r,c)>0) {
            label = countBombs(r,c);
        }
        //your code here
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
        if(buttons.contains(buttons(r,c))){
            return true;
        }
        else {
            return false;
        }
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        int testR = r-1;
        int testC = c-1;
        for(int i = 0; i<=2;i++) {
            for(int z = 0; z<=2; z++) {
                if(buttons[testR+i][testC+z].isValid()) {
                    if(bombs.contains(buttons[testR+i][testC+z])) {
                        numBombs++;
                    }
                }
            }
        }
        //your code here
        return numBombs;
    }
}
//Work on mousePressed() method


