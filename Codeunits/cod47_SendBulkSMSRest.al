codeunit 50147 "Send SMS Rest"
{
    trigger OnRun();
    begin
        UserName := 'peikba';
        Password := 'WebCall123';
        Request.SetRequestUri('https://api.bulksms.com/v1/messages');
        RequestTxt := '{to: \"28929111\", body:\"Hello Mr. Smith!\"}';
        Request.Method('POST');
        Content.WriteFrom(RequestTxt);
        Content.GetHeaders(Headers);
        Headers.Remove('Content-Type');
        Headers.Add('Content-Type', 'application/json');
        Request.Content := Content;
        Request.GetHeaders(Headers);
        if UserName <> '' then begin
            AuthTxt := StrSubstNo('%1 %2', UserName, Password);
            TempBlob.WriteAsText(AuthTxt, TextEncoding::Windows);
            Headers.Add('Authorization', StrSubstNo('Basic %1', TempBlob.ToBase64String()));
        end;
        Client.Send(Request, Response);

        if not Response.IsSuccessStatusCode then
            error('The web service returned an error message:\\' + 'Status code: %1\' + 'Description: %2', Response.HttpStatusCode, Response.ReasonPhrase);
        Message('Ok!');
        /*
                ResponseMessage.Content.ReadAs(JsonText);
                JsonText := '[' + JsonText + ']';
                if not JsonArray.ReadFrom(JsonText) then
                    Error('Invalid response, expected an JSON array as root object');
                foreach jsonToken in JsonArray do
                begin
                    JsonObject := JsonToken.AsObject;
                    if Currency.findset then repeat
                        InsertCurrencyRate(Currency.Code);
                    until Currency.Next=0;
                end;
                page.run(0,CurrencyRate);
            end;

            local procedure InsertCurrencyRate(inCurrencyCode: Code[10]);
            var
                TokenName : Text[50];
                LowerCurrCode : Text[10];

            begin
                CurrencyRate.init;
                LowerCurrCode:=LowerCase(inCurrencyCode);
                if not JsonObject.Get(LowerCurrCode, JsonToken) then
                    exit;
                TokenName:='$.' + LowerCurrCode + '.code';
                CurrencyRate."Currency Code" := format(SelectJsonToken(JsonObject,TokenName));
                CurrencyRate."Exchange Rate Amount" := 100;
                TokenName:='$.' + LowerCurrCode + '.inverseRate';
                evaluate(InvExchRate, format(SelectJsonToken(JsonObject, TokenName)));
                CurrencyRate."Relational Exch. Rate Amount" := InvExchRate;
                TokenName:='$.' + LowerCurrCode + '.date';
                */
    end;


    procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;

    procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;


    var
        Response: HttpResponseMessage;
        Request: HttpRequestMessage;
        Headers: HttpHeaders;
        Content: HttpContent;
        RequestTxt: text;
        Client: HttpClient;
        UserName: Text;
        Password: Text;
        AuthTxt: Text;
        TempBlob: Record TempBlob;
        JsonToken: JsonToken;
        JsonValue: JsonValue;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonText: text;
        CurrencyRate: Record "Currency Exchange Rate" temporary;
        Currency: Record Currency;
        InvExchRate: Decimal;
}