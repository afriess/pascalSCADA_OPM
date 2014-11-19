unit hmicolorpropertyconnector;

{$mode delphi}

interface

uses
  Classes, sysutils, HMIZones, hmiobjectcolletion, ProtocolTypes, HMITypes,
  Tag, PLCTag, Graphics;

type
  //forward class declaration.
  TColorZone = class;

  {$IFDEF PORTUGUES}
  {:
  Coleção de zonas de cores.
  @seealso(TZone)
  @seealso(TZones)
  @seealso(TColorZone)
  }
  {$ELSE}
  {:
  Collection of color zones.
  @seealso(TZone)
  @seealso(TZones)
  @seealso(TColorZone)
  }
  {$ENDIF}
  TColorZones = class(TZones)
  public
    //: @exclude
    constructor Create(Owner:TPersistent);

    {$IFDEF PORTUGUES}
    //: Adiciona uma nova zona de cor.
    {$ELSE}
    //: Adds a new color zone into the collection.
    {$ENDIF}
    function Add:TColorZone;
  end;

  {$IFDEF PORTUGUES}
  {:
  Implementa uma zona de cor.
  @seealso(TZone)
  @seealso(TZones)
  @seealso(TColorZones)
  }
  {$ELSE}
  {:
  Color class zone.
  @seealso(TZone)
  @seealso(TZones)
  @seealso(TColorZones)
  }
  {$ENDIF}

  { TColorZone }

  TColorZone = class(TZone)
  private
    FResult: TColor;
    procedure SetZoneResult(AValue: TColor);
  protected
    function GetDisplayName: string; override;
  published
    property ZoneResult:TColor read FResult write SetZoneResult;
  end;

  //////////////////////////////////////////////////////////////////////////////

  //: @exclude
  TObjectWithColorPropetiesColletionItem = class;

  {$IFDEF PORTUGUES}
  {:
  Implementa uma coleção de objetos com propriedades do tipo Boolean.
  @seealso(TObjectColletion)
  }
  {$ELSE}
  {:
  Implements a collection with objects that contains boolean properties.
  @seealso(TObjectColletion)
  }
  {$ENDIF}
  TObjectWithColorPropetiesColletion = class(TObjectColletion)
  public
    constructor Create(AOwner:TComponent);
    function Add: TObjectWithColorPropetiesColletionItem;
  end;

  {$IFDEF PORTUGUES}
  {:
  Implementa um item da coleção de objetos com propriedades booleanas.
  @seealso(TObjectColletionItem)
  }
  {$ELSE}
  {:
  Implements a item of a collection with objects that contains boolean properties.
  @seealso(TObjectColletionItem)
  }
  {$ENDIF}

  { TObjectWithColorPropetiesColletionItem }

  TObjectWithColorPropetiesColletionItem = class(TObjectColletionItem)
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(ACollection: TCollection); override;
    procedure ApplyResult(Result:TColor); virtual;
  end;

  //////////////////////////////////////////////////////////////////////////////

  { THMIBooleanPropertyConnector }

  THMIColorPropertyConnector = class(TComponent, IHMITagInterface)
  private
    FTag:TPLCTag;
    FConditionZones:TColorZones;
    FObjects:TObjectWithColorPropetiesColletion;    procedure ConditionItemChanged(Sender: TObject);
    procedure CollectionNeedsComponentState(var CurState: TComponentState);
    procedure ObjectItemChanged(Sender: TObject);
    function GetConditionZones: TColorZones;
    function GetObjects: TObjectWithColorPropetiesColletion;
    procedure SetConditionZones(AValue: TColorZones);
    procedure SetHMITag(AValue: TPLCTag);
    procedure SetObjects(AValue: TObjectWithColorPropetiesColletion);

    //: @seealso(IHMITagInterface.NotifyReadOk)
    procedure NotifyReadOk;
    //: @seealso(IHMITagInterface.NotifyReadFault)
    procedure NotifyReadFault;
    //: @seealso(IHMITagInterface.NotifyWriteOk)
    procedure NotifyWriteOk;
    //: @seealso(IHMITagInterface.NotifyWriteFault)
    procedure NotifyWriteFault;
    //: @seealso(IHMITagInterface.NotifyTagChange)
    procedure NotifyTagChange(Sender:TObject);
    //: @seealso(IHMITagInterface.RemoveTag)
    procedure RemoveTag(Sender:TObject);

    procedure RecalculateObjectsProperties;
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Conditions:TColorZones read GetConditionZones write SetConditionZones;
    property AffectedObjects:TObjectWithColorPropetiesColletion read GetObjects write SetObjects;
    property PLCTag:TPLCTag read FTag write SetHMITag;
  end;

implementation

uses typinfo, rttiutils, hsstrings;

{ THMIBooleanPropertyConnector }

procedure THMIColorPropertyConnector.ConditionItemChanged(Sender: TObject);
begin
  RecalculateObjectsProperties
end;

procedure THMIColorPropertyConnector.CollectionNeedsComponentState(
  var CurState: TComponentState);
begin
  CurState:=ComponentState;
end;

procedure THMIColorPropertyConnector.ObjectItemChanged(Sender: TObject);
begin
  RecalculateObjectsProperties
end;

function THMIColorPropertyConnector.GetConditionZones: TColorZones;
begin
  Result:=FConditionZones;
end;

function THMIColorPropertyConnector.GetObjects: TObjectWithColorPropetiesColletion;
begin
  Result:=FObjects;
end;

procedure THMIColorPropertyConnector.SetConditionZones(AValue: TColorZones);
begin
  FConditionZones.Assign(AValue);
end;

procedure THMIColorPropertyConnector.SetHMITag(AValue: TPLCTag);
begin
  if FTag=AValue then Exit;

  //se o tag esta entre um dos aceitos.
  //check if the tag is valid (only numeric tags)
  if (AValue<>nil) and (not Supports(AValue, ITagNumeric)) then
     raise Exception.Create(SonlyNumericTags);

  if FTag<>nil then begin
    FTag.RemoveCallBacks(Self as IHMITagInterface);
  end;

  //adiona o callback para o novo tag
  //link with the new tag.
  if AValue<>nil then begin
    AValue.AddCallBacks(Self as IHMITagInterface);
    FTag := AValue;
    RecalculateObjectsProperties;
  end;
  FTag:=AValue;
end;

procedure THMIColorPropertyConnector.SetObjects(
  AValue: TObjectWithColorPropetiesColletion);
begin
  FObjects.Assign(AValue);
end;

procedure THMIColorPropertyConnector.NotifyReadOk;
begin
  RecalculateObjectsProperties;
end;

procedure THMIColorPropertyConnector.NotifyReadFault;
begin
  RecalculateObjectsProperties;
end;

procedure THMIColorPropertyConnector.NotifyWriteOk;
begin
  RecalculateObjectsProperties;
end;

procedure THMIColorPropertyConnector.NotifyWriteFault;
begin
  RecalculateObjectsProperties;
end;

procedure THMIColorPropertyConnector.NotifyTagChange(Sender: TObject);
begin
  RecalculateObjectsProperties;
end;

procedure THMIColorPropertyConnector.RemoveTag(Sender: TObject);
begin
  if Sender=FTag then
     FTag:=nil;
end;

procedure THMIColorPropertyConnector.RecalculateObjectsProperties;
var
  x: TColorZone;
  o: Integer;
begin
  if csDesigning in ComponentState then exit;
  if Assigned(FTag) and Supports(FTag,ITagNumeric) then begin
    x:=TColorZone(FConditionZones.GetZoneFromValue((FTag as ITagNumeric).Value));
    for o:=0 to AffectedObjects.Count-1 do
      TObjectWithColorPropetiesColletionItem(AffectedObjects.Items[o]).ApplyResult(x.ZoneResult);
  end;
end;

procedure THMIColorPropertyConnector.Loaded;
begin
  inherited Loaded;
  FConditionZones.Loaded;
  FObjects.Loaded;
  RecalculateObjectsProperties;
end;

procedure THMIColorPropertyConnector.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: Integer;
begin
  inherited Notification(AComponent, Operation);
  if Operation=opRemove then begin
    for i:=0 to FObjects.Count-1 do begin
      if TObjectWithColorPropetiesColletionItem(FObjects.Items[i]).TargetObject=AComponent then begin
        TObjectWithColorPropetiesColletionItem(FObjects.Items[i]).TargetObject:=nil;
      end;
    end;
  end;
end;

constructor THMIColorPropertyConnector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FConditionZones:=TColorZones.Create(Self);
  FConditionZones.OnCollectionItemChange:=ConditionItemChanged;
  FConditionZones.OnNeedCompState:=CollectionNeedsComponentState;
  FObjects:=TObjectWithColorPropetiesColletion.Create(Self);
  FObjects.OnCollectionItemChange:=ObjectItemChanged;
  FObjects.OnNeedCompState:=CollectionNeedsComponentState;
end;

destructor THMIColorPropertyConnector.Destroy;
var
  o: Integer;
begin
  if FObjects.Owner is TComponent then
    for o:=0 to FObjects.Count-1 do begin
      if assigned(TObjectWithColorPropetiesColletionItem(FObjects.Items[o]).TargetObject) then
        TObjectWithColorPropetiesColletionItem(FObjects.Items[o]).TargetObject.RemoveFreeNotification(TComponent(FObjects.Owner));
    end;
  FreeAndNil(FConditionZones);
  FreeAndNil(FObjects);
  SetHMITag(nil);
  inherited Destroy;
end;

{ TObjectWithColorPropetiesColletionItem }

function TObjectWithColorPropetiesColletionItem.GetDisplayName: string;
begin
  if Assigned(TargetObject) and (TargetObjectProperty<>'') then
    Result:=TargetObject.Name+'.'+TargetObjectProperty
  else
    Result:='(unused)';
end;

constructor TObjectWithColorPropetiesColletionItem.Create(
  ACollection: TCollection);
begin
  inherited Create(ACollection);
  fRequiredTypeName:=PTypeInfo(TypeInfo(TColor)).Name ;
end;

procedure TObjectWithColorPropetiesColletionItem.ApplyResult(Result: TColor);
begin
  if (not AcceptObject(TargetObject)) or
     (not AcceptObjectProperty(TargetObjectProperty)) then exit;

  SetPropValue(TargetObject,TargetObjectProperty,Result);
end;

{ TObjectWithColorPropetiesColletion }

constructor TObjectWithColorPropetiesColletion.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TObjectWithColorPropetiesColletionItem);
end;

function TObjectWithColorPropetiesColletion.Add: TObjectWithColorPropetiesColletionItem;
begin
  Result:=TObjectWithColorPropetiesColletionItem(inherited Add);
end;

{ TColorZones}

constructor TColorZones.Create(Owner: TPersistent);
begin
  inherited Create(Owner, TColorZone);
end;

function TColorZones.Add: TColorZone;
begin
  Result:=TColorZone(inherited Add);
end;

{ TColorZone }

procedure TColorZone.SetZoneResult(AValue: TColor);
begin
  if FResult=AValue then Exit;
  FResult:=AValue;
  NotifyChange;
end;

function TColorZone.GetDisplayName: string;
begin
  Result:=inherited GetDisplayName+', Result='+ColorToString(ZoneResult);
end;

end.