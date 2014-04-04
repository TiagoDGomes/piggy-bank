<%-- 
    Document   : tetris
    Created on : 22/12/2012, 20:46:11
    Author     : Tiago Donizetti Gomes
--%>

<%@taglib prefix="util" tagdir="/WEB-INF/tags/util/" %>
<%@tag description="Jogo de Tetris" pageEncoding="ISO-8859-1"%>
<script type="text/javascript" src="js/MIDI.player.js"></script>
<script type="text/javascript">
    var tetrisGamePath = "../games/tetris/"; 
    var valorArrecadado = 0;
    var valorAtual = 0;
    
    function atualizar(){
        var valorAtual = (Lines * 1) * (Level * 3);
        document.getElementById("tetris_pontos").innerHTML = Score;
        document.getElementById("tetris_nivel").innerHTML = Level;
        document.getElementById("tetris_linhas").innerHTML = Lines;
        if (valorAtual!=valorArrecadado){
            $("#valorArrecadado").html(valorAtual);
            eventAdicionarValor(valorAtual - valorArrecadado);
            valorArrecadado = valorAtual;
            
        }
        //document.getElementById("valorArrecadado").innerHTML = (Lines*10) * (Level);
        
        
    }
    function eventFimDeJogo(){
        document.getElementById("statusJogo").innerHTML = "Fim de jogo! Aguarde enquanto seu saldo est� sendo atualizado...";
        //eventAdicionarValor(document.getElementById("valorArrecadado").innerHTML);
        document.getElementById("statusJogo").innerHTML = "Fim de jogo!";
        
    }
</script>


<!--
    Tetris is a PC-Game, which is a part of the '7 by one stroke' package, written in HTML and JavaScript
    Author: Lutz Tautenhahn
-->


<script language="JavaScript1.2">
    if (navigator.appName != "Microsoft Internet Explorer"){
        document.captureEvents(Event.KEYDOWN)
    }        
    document.onkeydown = NetscapeKeyDown;
    function NetscapeKeyDown(key)    { 
        KeyDown(key.which);
    }  
</script>
<script for="document" event="onkeydown()" language="JScript">
    if (window.event) {
        KeyDown(window.event.keyCode);
    }       
</script>
<script type="text/javascript">
    
    var i, j, IsOver, MaxX=10, MaxY=20, NextCol, Col, Score, Lines, IsPreview=true, IsHideFocus=true, Level;
    PosX=new Array(4);
    PosY=new Array(4);
    Delay=new Array(828,620,464,348,260,196,148,112,84,64,48,36,27);
    Fld = new Array(MaxX);
    for (i=0; i < MaxX; i++)
    { Fld[i]=new Array(MaxY);
    } 
    RFld=new Array(MaxY);
    Pic= new Array(8);
    for (i=0; i<8; i++)
    { Pic[i] = new Image(); 
        Pic[i].src = tetrisGamePath + "tetris_"+i+".gif"; 
    }
    PrePic= new Array(8);
    for (i=0; i<8; i++)
    { PrePic[i] = new Image(); 
        PrePic[i].src = tetrisGamePath + "tetrisp"+i+".gif"; 
    }
    PatternX=new Array(7);
    PatternY=new Array(7);
    PatternX[0]=new Array(0,1,2,3);
    PatternY[0]=new Array(0,0,0,0);
    PatternX[1]=new Array(2,1,0,0);
    PatternY[1]=new Array(0,0,0,1);
    PatternX[2]=new Array(2,1,1,0);
    PatternY[2]=new Array(1,1,0,0);
    PatternX[3]=new Array(1,2,1,2);
    PatternY[3]=new Array(0,0,1,1);
    PatternX[4]=new Array(1,2,2,3);
    PatternY[4]=new Array(1,1,0,0);
    PatternX[5]=new Array(1,2,3,3);
    PatternY[5]=new Array(0,0,0,1);
    PatternX[6]=new Array(1,2,3,2);
    PatternY[6]=new Array(0,0,0,1);
    function KeyDown(whichkey)
    { //alert(whichkey);
        if (IsOver) return;
        if (PosY<0) return;
        if (whichkey == 37) Left();
        if (whichkey == 38) Rotate();
        if (whichkey == 39) Right();
        if (whichkey == 40) Down();

        if (whichkey == 50) Down();
        if (whichkey == 52) Left();
        if (whichkey == 53) Down();
        if (whichkey == 54) Right();
        if (whichkey == 56) Rotate();

        if (whichkey == 65458) Down();
        if (whichkey == 65460) Left();
        if (whichkey == 65461) Down();
        if (whichkey == 65462) Right();
        if (whichkey == 65464) Rotate();
        
        if (whichkey == 107) eventAdicionarValor(30);
    }  
    function Pause(){ 
        IsOver=true;
        alert("Clique OK para continuar!");
        setTimeout("Init(false)",540);
        MIDI.player.pause();
    }
    function New(){ 
        IsOver=true;
        valorAtual = 0;
        setTimeout("Init(true)",540);
        MIDI.player.loadFile("tetris/Tetris_MusicA.mid");
    }
    function Init(nn){ 
        IsOver=false;
        if (nn) { 
            for (i=0; i<MaxX; i++) { 
                for (j=0; j<MaxY; j++){
                    Fld[i][j]=0;
                }                    
            }
            PosY[0]=-1;
            Score=0;
            Level=1;
            Lines=0;
            window.document.ScoreForm.Score.value = Score;
            window.document.ScoreForm.Level.value = Level;
            window.document.ScoreForm.Lines.value = Lines;
            atualizar();
            RefreshScreen();
            NextCol=Math.floor(Math.random()*100)%7;
        }
        //setTimeout("Go()",50*(11-Level));
        setTimeout("Go()",Delay[Level]);
        HideFocus();
    }
    function Go() { 
        if (IsOver) return;
        var nn;
        if (PosY[0]<0) { 
            Col=NextCol;
            NextCol=Math.floor(Math.random()*100)%7;
            if (IsPreview) document.images[MaxX*MaxY].src = PrePic[NextCol+1].src;
            else document.images[MaxX*MaxY].src = PrePic[0].src;
            for (nn=0; nn<4; nn++) { 
                PosX[nn]=PatternX[Col][nn]+3;
                PosY[nn]=PatternY[Col][nn]+1;
                if (Fld[PosX[nn]][PosY[nn]]>0) IsOver=true;
            }
            if (IsOver) { 
                if (CanShift(0,-1)) { 
                    for (nn=0; nn<4; nn++){
                        document.images[PosX[nn]+MaxX*(PosY[nn]-1)].src = Pic[Col+1].src;
                    }                        
                }
                if (window.opener) { 
                    if (window.opener.SetHighscores){
                        window.opener.SetHighscores("Tetris","",Score,1);
                    }                        
                }
                eventFimDeJogo();
                //if (confirm("Valeu, voc� tem "+Score+" pontos ! Voc� quer jogar mais de novo ?")) {
                    //Init(true);
                //}
                return;
            }
            for (nn=0; nn<4; nn++){ 
                Fld[PosX[nn]][PosY[nn]]=Col+1;
                document.images[PosX[nn]+MaxX*PosY[nn]].src = Pic[Col+1].src;
            }  
        }
        else { 
            for (nn=0; nn<4; nn++){
                Fld[PosX[nn]][PosY[nn]]=0;
            }               
            if (CanShift(0,1)){ 
                for (nn=0; nn<4; nn++){
                    Fld[PosX[nn]][PosY[nn]]=Col+1;
                }                    
                Shift(0,1); 
            }
            else
            { for (nn=0; nn<4; nn++)
                    Fld[PosX[nn]][PosY[nn]]=Col+1;
                PosY[0]=-1;
                Remove();
                window.document.ScoreForm.Score.value = Score;
                window.document.ScoreForm.Level.value = Level;
                window.document.ScoreForm.Lines.value = Lines;
                atualizar();
            }
        }
        //setTimeout("Go()",50*(11-Level));
        setTimeout("Go()",Delay[Level]);
    }
    function CanShift(xx, yy)
    { var nn, cc=true;
        for (nn=0; nn<4; nn++)
        { if (PosX[nn]+xx<0) return(false);
            if (PosX[nn]+xx>=MaxX) return(false);
            if (PosY[nn]+yy>=MaxY) return(false);
            if (Fld[PosX[nn]+xx][PosY[nn]+yy]>0) return(false);
        }
        return(true); 
    }
    function GetFld(xx, yy)
    { if (xx<0) return(-1);
        if (xx>=MaxX) return(-1);
        if (yy<0) return(-1);
        if (yy>=MaxY) return(-1);
        return(Fld[xx][yy]);
    }
    function Rotate()
    { if (IsOver) return;
        if (PosY[0]<0) return;
        var nn, ii, jj;
        for (nn=0; nn<4; nn++)
            Fld[PosX[nn]][PosY[nn]]=0;
        if (!CanRotate())
        { for (nn=0; nn<4; nn++)
                Fld[PosX[nn]][PosY[nn]]=Col+1;
            return;
        }  
        for (nn=0; nn<4; nn++)
            document.images[PosX[nn]+MaxX*PosY[nn]].src = Pic[0].src;
        if (Col==0)
        { if (PosY[0]==PosY[1])
            { PosX[0]+=2;PosY[0]-=1;
                PosX[1]+=1;PosY[2]+=1;
                PosX[3]-=1;PosY[3]+=2;
            }
            else
            { PosX[0]-=2;PosY[0]+=2;
                PosX[1]-=1;PosY[1]+=1;
                PosX[3]+=1;PosY[3]-=1;
            }
        }
        if ((Col==2)||(Col==4))
        { if (PosY[0]==PosY[1])
            { PosX[0]-=1*(3-Col);PosY[0]-=1;
                PosX[2]-=1*(3-Col);PosY[2]+=1;
                PosY[3]+=2;
            }
            else
            { PosX[0]+=1*(3-Col);PosY[0]+=1;
                PosX[2]+=1*(3-Col);PosY[2]-=1;
                PosY[3]-=2;
            }
        }
        if ((Col==1)||(Col==5)||(Col==6))
        { nn=PosY[1]-PosY[0];
            PosY[0]=PosY[1]+(PosX[1]-PosX[0]);
            PosX[0]=PosX[1]-nn;
            nn=PosY[1]-PosY[2];
            PosY[2]=PosY[1]+(PosX[1]-PosX[2]);
            PosX[2]=PosX[1]-nn;  
            nn=PosY[1]-PosY[3];
            PosY[3]=PosY[1]+(PosX[1]-PosX[3]);
            PosX[3]=PosX[1]-nn;      
        }  
        for (nn=0; nn<4; nn++)
            document.images[PosX[nn]+MaxX*PosY[nn]].src = Pic[Col+1].src;
    }
    function CanRotate()
    { var ii, jj, iim, jjm, dd=3;
        if (Col==3) return(false);
        if (Col==0)
        { iim=PosX[2]-2; 
            jjm=PosY[2]-1;
            dd=4;
        }
        else
        { iim=PosX[1]-1; 
            jjm=PosY[1]-1;
        }
        for (ii=iim; ii<iim+dd; ii++)
        { for (jj=jjm; jj<jjm+dd; jj++)
            { if (GetFld(ii,jj)!=0) return(false);
            }
        } 
        return(true);
    }
    function Left()
    { if (IsOver) return;
        if (PosY[0]<0) return;
        for (nn=0; nn<4; nn++)
            Fld[PosX[nn]][PosY[nn]]=0;
        if (CanShift(-1,0))
        { for (nn=0; nn<4; nn++)
                Fld[PosX[nn]][PosY[nn]]=Col+1;
            Shift(-1,0);
        }
        else
        { for (nn=0; nn<4; nn++)
                Fld[PosX[nn]][PosY[nn]]=Col+1;
        }
    }
    function Right()
    { if (IsOver) return;
        if (PosY[0]<0) return;
        for (nn=0; nn<4; nn++)
            Fld[PosX[nn]][PosY[nn]]=0;
        if (CanShift(1,0))
        { for (nn=0; nn<4; nn++)
                Fld[PosX[nn]][PosY[nn]]=Col+1;
            Shift(1,0);
        }
        else
        { for (nn=0; nn<4; nn++)
                Fld[PosX[nn]][PosY[nn]]=Col+1;  
        }
    }
    function Down()    { 
        if (IsOver) return;
        if (PosY[0]<0) return;
        var dd=0;
        for (nn=0; nn<4; nn++)
            Fld[PosX[nn]][PosY[nn]]=0;
        while (CanShift(0,dd+1)) dd++;
        for (nn=0; nn<4; nn++)
            Fld[PosX[nn]][PosY[nn]]=Col+1;
        if (dd>0) Shift(0, dd);
    }
    function Shift(dx, dy)
    { var nn;
        for (nn=0; nn<4; nn++)
        { Fld[PosX[nn]][PosY[nn]]=0;
            document.images[PosX[nn]+MaxX*PosY[nn]].src = Pic[0].src;
        }
        for (nn=0; nn<4; nn++)
        { PosX[nn]+=dx;
            PosY[nn]+=dy;
            Fld[PosX[nn]][PosY[nn]]=Col+1;
            document.images[PosX[nn]+MaxX*PosY[nn]].src = Pic[Col+1].src;
        }
    }
    function Remove()
    { var xx, yy, nn=0;
        Score+=20;
        for (yy=0; yy<MaxY; yy++) RFld[yy]=1;
        for (xx=0; xx<MaxX; xx++)
        { for (yy=0; yy<MaxY; yy++)
            { if (Fld[xx][yy]==0) RFld[yy]=0;
            }
        }
        for (yy=MaxY-1; yy>=0; yy--)
        { if (RFld[yy]>0)
            { nn++
                for (xx=0; xx<MaxX; xx++)
                    Fld[xx][yy]=0;
            }
            else
            { if (nn>0)
                { for (xx=0; xx<MaxX; xx++)
                    { Fld[xx][yy+nn]=Fld[xx][yy];
                        Fld[xx][yy]=0;
                    }  
                }
            }   
        }
        Score+=100*nn;
        Lines+=nn;
        if ((Score>=1500*Level)&&(Level<12)) Level++;
        if (nn>0) RefreshScreen();
    }
    function RefreshScreen()
    { for (i=0; i < MaxX; i++)
        { for (j=0; j < MaxY; j++)
                window.document.images[i+MaxX*j].src = Pic[Fld[i][j]].src; 
        }
    }
    function HideFocus()
    { if (IsHideFocus)
        { document.ScoreForm.Score.focus();
            document.ScoreForm.Score.blur();
        }
    }
</script>
<form name="ScoreForm">
    <div class="jogo tetris" style="" >
        <div class="nucleo" style=" float: left">
            <script type="text/javascript">
                document.open("text/plain");
                document.writeln("<div class=\"linha\" style=\"height: 24px;\">");
                for (j=0; j < MaxY; j++) { 
                    for (i=0; i < MaxX; i++){  
                        document.write("<span><img src=\""+tetrisGamePath +"tetris_0.gif\"></span>");
                    }
                    document.writeln("</div><div class=\"linha\" style=\"height: 24px;\">");
                }
                document.writeln("</div>");

                if (navigator.appName == "Konqueror"){
                    document.write("</div><div>");
                    document.write("<input width=0 height=0 style=\"width:0; height:0\" name=\"KeyCatch\" onBlur=\"KeyCatchFocus()\" onKeyUp=\"KeyCatchChange()\">");
                    KeyCatchFocus();
                    IsHideFocus=false;
                }
                
                function KeyCatchFocus() { 
                    setTimeout("document.forms[0].KeyCatch.focus()",100);
                }
                
                function KeyCatchChange() { 
                    var vv=""+document.forms[0].KeyCatch.value;
                    if (vv=="") return;
                    KeyDown(vv.charCodeAt(0));
                    document.forms[0].KeyCatch.value="";
                }

                document.close();
            </script>
            <div>&copy; 2005 Tetris JavaScript by Lutz Tautenhahn</div>
        </div>
        
        <div class="placar">
            <img src="tetris/tetrisp0.gif" alt="Previs�o" /><br />
            <input type="button" value="Pausar" onclick="Pause()" /><br />
            <input type="button" value="Reiniciar" onclick="New()" /><br />
            <span id="valorArrecadado" class="notaDinheiro" style="width: 110px">0</span><br />
            <span class="lbl">Pontos: </span><span id="tetris_pontos">0</span><br />
            <span class="lbl">N�vel: </span><span id="tetris_nivel">0</span><br />
            <span class="lbl">Linhas: </span><span id="tetris_linhas">0</span><br />   
            
            <span id="statusJogo"></span>
            
        </div>
        
        
        <table style="display: none">
            <tr><td></td>
                <td>&nbsp;&nbsp;&nbsp;</td>
                <td valign=top>
                    <table id="tetrisTable" ><tr><td>
                                <table>
                                    <tr><td align="center"><input type="button" width="70" style="width:70;" value="Pausa" onclick="Pause()"></td></tr>
                                    <tr><td>&nbsp;</td></tr>
                                    <tr><td align="center"><input type="button" width="70" style="width:70;" value="Novo" onclick="New()"></td></tr>
                                    <tr><td>&nbsp;</td></tr>
                                    <tr><td align="center">Pontos:</td></tr>
                                    <tr><td align="center"><input type="text" width="70" style="width:70; background-color:#ffffff" name="Score" onclick="HideFocus()"></td></tr>
                                    <tr><td align="center">N�vel:</td></tr>
                                    <tr><td align="center"><input type="text" width="70" style="width:70; background-color:#ffffff" name="Level" onclick="HideFocus()"></td></tr>
                                    <tr><td align="center">Linhas:</td></tr>
                                    <tr><td align="center"><input type="button" width="70" style="width:70; background-color:#ffffff" name="Lines" onclick="HideFocus()"></td></tr>
                                    <tr><td align="center"><input type="checkbox" onclick="IsPreview=this.checked; HideFocus();">Previs�o</td></tr>
                                    <tr><td align="center"><table border=2 cellpadding=0 cellspacing=3><tr><td><!--<img src="tetrisp0.gif" border=0>--></td></tr></table></td></tr>
                                </table></td></tr></table>
                </td></tr></table>
        <script type="text/javascript">
            Init(true);
        </script>
    </div>
    
</form>
<!--<button onclick="eventAdicionarValor(100)">Add</button>-->