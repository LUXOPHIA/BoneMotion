unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  LUX.GPU.OpenGL.Viewer;

type
  TForm2 = class(TForm)
    GLViewer1: TGLViewer;
  private
    { private 宣言 }
  public
    { public 宣言 }
  end;

var
  Form2: TForm2;

implementation //############################################################### ■

{$R *.fmx}

end. //######################################################################### ■
