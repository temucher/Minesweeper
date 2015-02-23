import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import de.bezier.guido.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Minesweeper extends PApplet {

//Teagan Mucher, Block 4 AP CS


//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList();
public void setup ()
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
    boolean response = true;
    for(int i = 0; i<=bombs.size(); i++) {
        if(!bombs.get(i).isMarked()) {
            response = false;
        }
    }
    return response;
}
public void displayLosingMessage()
{
    String loseMsg = "You suck";
    for(int i = 0; i<=7; i++) {
        buttons[10][3+i].setLabel(loseMsg.substring(i-1,i));
    }
    // for(int z = 0; z<= bombs.size(); z++) {
    //     if(!bombs.get(z).isMarked()) {bombs.get(z).marked = !marked;}
    // }
}
public void displayWinningMessage()
{    
    String winMsg = "Congrats";
    for(int i =0; i<=7; i++) {
        buttons[10][3+i].setLabel(winMsg.substring(i-1,i));
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
        else if(countBombs(r,c)>0) {
            label = Integer.toString(countBombs(r,c));
        }
        else {
            for(int i = 0; i<=2;i++) {
                for(int z = 0; z<=2; z++) {
                    buttons[r+i][c+z].mousePressed();
                }
            }
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
        return buttons.contains(this);
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
//debugging, trying to get it to run


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Minesweeper" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
