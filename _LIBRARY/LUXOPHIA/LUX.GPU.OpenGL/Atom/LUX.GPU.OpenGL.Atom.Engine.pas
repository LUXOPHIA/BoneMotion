﻿unit LUX.GPU.OpenGL.Atom.Engine;

interface //#################################################################### ■

uses Winapi.OpenGL, Winapi.OpenGLext,
     LUX,
     LUX.GPU.OpenGL.Atom,
     LUX.GPU.OpenGL.Atom.Porter,
     LUX.GPU.OpenGL.Atom.Progra;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLEngine

     IGLEngine = interface( IGLProgra )
     ['{0B2FDEDE-30D3-439B-AC76-E61F9E028CD0}']
     {protected}
       ///// アクセス
       function GetVerBufs :TGLPorterV;
       function GetUniBufs :TGLPorterU;
       function GetImagers :TGLPorterI;
     {public}
       ///// プロパティ
       property VerBufs :TGLPorterV read GetVerBufs;
       property UniBufs :TGLPorterU read GetUniBufs;
       property Imagers :TGLPorterI read GetImagers;
     end;

     //-------------------------------------------------------------------------

     TGLEngine = class( TGLProgra, IGLEngine )
     private
     protected
       _VerBufs :TGLPorterV;
       _UniBufs :TGLPorterU;
       _Imagers :TGLPorterI;
       _StoBufs :TGLPorterS;
       ///// アクセス
       function GetVerBufs :TGLPorterV;
       function GetUniBufs :TGLPorterU;
       function GetImagers :TGLPorterI;
       function GetStoBufs :TGLPorterS;
       ///// イベント
       procedure DoOnLinked; override;
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property VerBufs :TGLPorterV read GetVerBufs;
       property UniBufs :TGLPorterU read GetUniBufs;
       property Imagers :TGLPorterI read GetImagers;
       property StoBufs :TGLPorterS read GetStoBufs;
       ///// メソッド
       procedure Attach( const Shader_:IGLShader ); override;
       procedure Detach( const Shader_:IGLShader ); override;
       procedure Use; override;
       procedure Unuse; override;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLEngine

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TGLEngine.GetVerBufs :TGLPorterV;
begin
     Result := _VerBufs;
end;

function TGLEngine.GetUniBufs :TGLPorterU;
begin
     Result := _UniBufs;
end;

function TGLEngine.GetImagers :TGLPorterI;
begin
     Result := _Imagers;
end;

function TGLEngine.GetStoBufs :TGLPorterS;
begin
     Result := _StoBufs;
end;

/////////////////////////////////////////////////////////////////////// イベント

procedure TGLEngine.DoOnLinked;
begin
     _VerBufs.AddPorts;
     _UniBufs.AddPorts;
     _Imagers.AddPorts;
     _StoBufs.AddPorts;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLEngine.Create;
begin
     inherited Create;

     _VerBufs := TGLPorterV.Create( Self as IGLEngine );
     _UniBufs := TGLPorterU.Create( Self as IGLEngine );
     _Imagers := TGLPorterI.Create( Self as IGLEngine );
     _StoBufs := TGLPorterS.Create( Self as IGLEngine );
end;

destructor TGLEngine.Destroy;
begin
     _VerBufs.DisposeOf;
     _UniBufs.DisposeOf;
     _Imagers.DisposeOf;
     _StoBufs.DisposeOf;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TGLEngine.Attach( const Shader_:IGLShader );
begin
     inherited;

     Shader_.Attach( Self as IGLEngine );
end;

procedure TGLEngine.Detach( const Shader_:IGLShader );
begin
     inherited;

     Shader_.Detach( Self as IGLEngine );
end;

//------------------------------------------------------------------------------

procedure TGLEngine.Use;
begin
     inherited;

     _VerBufs.Use;
     _UniBufs.Use;
     _Imagers.Use;
     _StoBufs.Use;
end;

procedure TGLEngine.Unuse;
begin
     _VerBufs.Unuse;
     _UniBufs.Unuse;
     _Imagers.Unuse;
     _StoBufs.Unuse;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■