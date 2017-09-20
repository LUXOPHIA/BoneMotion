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
  LUX.Motion.BVH.OpenGL, FMX.Media;

type
  TForm1 = class(TForm)
    GLViewer1: TGLViewer;
    Timer1: TTimer;
    MediaPlayer1: TMediaPlayer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    _SkeletA :TBones;
    _SkeletK :TBones;
    _SkeletN :TBones;
    _Scener  :TGLScener;
    _Camera  :TGLCameraPers;
    _ShaperA :TGLBones;
    _ShaperK :TGLBones;
    _ShaperN :TGLBones;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math;

procedure TForm1.FormCreate(Sender: TObject);
begin
     _Scener := TGLScener.Create;

     _Camera := TGLCameraPers.Create( _Scener );

     with _Camera do
     begin
          Pose := TSingleM4.RotateY( DegToRad( -155 ) )
                * TSingleM4.RotateX( DegToRad( -30 ) )
                * TSingleM4.Translate( 0, 50, 500 );

          Angl := DegToRad( 60{°} );
     end;

     GLViewer1.Camera := _Camera;

     //////////

     _SkeletA := TBones.Create;
     _SkeletK := TBones.Create;
     _SkeletN := TBones.Create;

     _SkeletA.LoadFromFileBVH( '..\..\_DATA\aachan.bvh' );
     _SkeletK.LoadFromFileBVH( '..\..\_DATA\kashiyuka.bvh' );
     _SkeletN.LoadFromFileBVH( '..\..\_DATA\nocchi.bvh' );

     //////////

     _ShaperA := TGLBones.Create( _Scener );
     _ShaperK := TGLBones.Create( _Scener );
     _ShaperN := TGLBones.Create( _Scener );

     _ShaperA.Bones := _SkeletA;
     _ShaperK.Bones := _SkeletK;
     _ShaperN.Bones := _SkeletN;

     //////////

     Timer1.Enabled := True;

     with MediaPlayer1 do
     begin
          FileName := '..\..\_DATA\Perfume_globalsite_sound.wav';
          Volume   := 0.5;

          Play;
     end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _Scener .DisposeOf;
     _SkeletA.DisposeOf;
     _SkeletK.DisposeOf;
     _SkeletN.DisposeOf;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
   T :Single;
   I :Integer;
begin
     T{s} := MediaPlayer1.CurrentTime / MediaTimeScale;
     I{f} := Round( T{s} / _SkeletA.FrameT{s/f} );

     _ShaperA.FrameI := I;
     _ShaperK.FrameI := I;
     _ShaperN.FrameI := I;

     GLViewer1.Repaint;

     Timer1.Enabled := ( MediaPlayer1.State = TMediaState.Playing );
end;

end. //######################################################################### ■
