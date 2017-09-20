unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  LUX, LUX.D1, LUX.D2, LUX.D3, LUX.M4,
  LUX.GPU.OpenGL.Viewer,
  LUX.GPU.OpenGL.Camera,
  LUX.GPU.OpenGL.Scener,
  LUX.GPU.OpenGL.Shaper,
  LUX.GPU.OpenGL.Matery,
  LUX.Motion.BVH,
  LUX.Motion.BVH.OpenGL;

type
  TForm1 = class(TForm)
    GLViewer1: TGLViewer;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    _Bones  :TBones;
    _Scener :TGLScener;
    _Camera :TGLCameraPers;
    _Shaper :TGLBones;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math;

procedure TForm1.FormCreate(Sender: TObject);
begin
     _Bones := TBones.Create;

     with _Bones do
     begin
          LoadFromFileBVH( '..\..\_DATA\aachan.bvh' );
     end;

     Timer1.Interval := Round( 1000 * _Bones.FrameT{sec} );

     //////////

     _Scener := TGLScener.Create;

     _Camera := TGLCameraPers.Create( _Scener );

     with _Camera do
     begin
          Pose := TSingleM4.RotateY( DegToRad( -180 ) )
                * TSingleM4.RotateX( DegToRad( -30 ) )
                * TSingleM4.Translate( 0, 0, 500 );

          Angl := DegToRad( 60{°} );
     end;

     GLViewer1.Camera := _Camera;

     //////////

     _Shaper := TGLBones.Create( _Scener );

     with _Shaper do
     begin
          Bones  := _Bones;
          FrameI := 0;
     end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _Scener.DisposeOf;
     _Bones .DisposeOf;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     with _Shaper do
     begin
          if FrameI < Bones.FrameN then FrameI := FrameI + 1;
     end;

     GLViewer1.Repaint;
end;

end. //######################################################################### ■
