unit uPostModel;

interface

type
  TPostsModel = class
  private
    FUserID: Integer;
    FBody: String;
    FTitle: String;
    FID: Integer;
    procedure SetBody(const Value: String);
    procedure SetID(const Value: Integer);
    procedure SetUserID(const Value: Integer);
    procedure SetTitle(const Value: String);
    { private declarations }
  public
    { public declarations }
    property UserID: Integer read FUserID write SetUserID;
    property ID: Integer read FID write SetID;
    property Title: String read FTitle write SetTitle;
    property Body: String read FBody write SetBody;
  end;

implementation

{ TPosts }

procedure TPostsModel.SetBody(const Value: String);
begin
  FBody := Value;
end;

procedure TPostsModel.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TPostsModel.SetUserID(const Value: Integer);
begin
  FUserID := Value;
end;

procedure TPostsModel.SetTitle(const Value: String);
begin
  FTitle := Value;
end;

end.
