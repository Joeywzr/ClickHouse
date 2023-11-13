DROP TABLE IF EXISTS hits_gcd;

CREATE TABLE hits_gcd (`WatchID` UInt64 CODEC (GCD,LZ4), `JavaEnable` UInt8 CODEC (GCD,LZ4), `Title` String, `GoodEvent` Int16, `EventTime` DateTime, `EventDate` Date, `CounterID` UInt32 CODEC (GCD,LZ4), `ClientIP` UInt32 CODEC (GCD,LZ4), `ClientIP6` FixedString(16), `RegionID` UInt32 CODEC (GCD,LZ4), `UserID` UInt64 CODEC (GCD,LZ4), `CounterClass` Int8, `OS` UInt8 CODEC (GCD,LZ4), `UserAgent` UInt8 CODEC (GCD,LZ4), `URL` String, `Referer` String, `URLDomain` String, `RefererDomain` String, `Refresh` UInt8 CODEC (GCD,LZ4), `IsRobot` UInt8 CODEC (GCD,LZ4), `RefererCategories` Array(UInt16) CODEC (GCD,LZ4), `URLCategories` Array(UInt16) CODEC (GCD,LZ4), `URLRegions` Array(UInt32) CODEC (GCD,LZ4), `RefererRegions` Array(UInt32) CODEC (GCD,LZ4), `ResolutionWidth` UInt16 CODEC (GCD,LZ4), `ResolutionHeight` UInt16 CODEC (GCD,LZ4), `ResolutionDepth` UInt8 CODEC (GCD,LZ4), `FlashMajor` UInt8 CODEC (GCD,LZ4), `FlashMinor` UInt8 CODEC (GCD,LZ4), `FlashMinor2` String, `NetMajor` UInt8 CODEC (GCD,LZ4), `NetMinor` UInt8 CODEC (GCD,LZ4), `UserAgentMajor` UInt16 CODEC (GCD,LZ4), `UserAgentMinor` FixedString(2), `CookieEnable` UInt8 CODEC (GCD,LZ4), `JavascriptEnable` UInt8 CODEC (GCD,LZ4), `IsMobile` UInt8 CODEC (GCD,LZ4), `MobilePhone` UInt8 CODEC (GCD,LZ4), `MobilePhoneModel` String, `Params` String, `IPNetworkID` UInt32 CODEC (GCD,LZ4), `TraficSourceID` Int8, `SearchEngineID` UInt16 CODEC (GCD,LZ4), `SearchPhrase` String, `AdvEngineID` UInt8 CODEC (GCD,LZ4), `IsArtifical` UInt8 CODEC (GCD,LZ4), `WindowClientWidth` UInt16 CODEC (GCD,LZ4), `WindowClientHeight` UInt16 CODEC (GCD,LZ4), `ClientTimeZone` Int16, `ClientEventTime` DateTime, `SilverlightVersion1` UInt8 CODEC (GCD,LZ4), `SilverlightVersion2` UInt8 CODEC (GCD,LZ4), `SilverlightVersion3` UInt32 CODEC (GCD,LZ4), `SilverlightVersion4` UInt16 CODEC (GCD,LZ4), `PageCharset` String, `CodeVersion` UInt32 CODEC (GCD,LZ4), `IsLink` UInt8 CODEC (GCD,LZ4), `IsDownload` UInt8 CODEC (GCD,LZ4), `IsNotBounce` UInt8 CODEC (GCD,LZ4), `FUniqID` UInt64 CODEC (GCD,LZ4), `HID` UInt32 CODEC (GCD,LZ4), `IsOldCounter` UInt8 CODEC (GCD,LZ4), `IsEvent` UInt8 CODEC (GCD,LZ4), `IsParameter` UInt8 CODEC (GCD,LZ4), `DontCountHits` UInt8 CODEC (GCD,LZ4), `WithHash` UInt8 CODEC (GCD,LZ4), `HitColor` FixedString(1), `UTCEventTime` DateTime, `Age` UInt8 CODEC (GCD,LZ4), `Sex` UInt8 CODEC (GCD,LZ4), `Income` UInt8 CODEC (GCD,LZ4), `Interests` UInt16 CODEC (GCD,LZ4), `Robotness` UInt8 CODEC (GCD,LZ4), `GeneralInterests` Array(UInt16) CODEC (GCD,LZ4), `RemoteIP` UInt32 CODEC (GCD,LZ4), `RemoteIP6` FixedString(16), `WindowName` Int32, `OpenerName` Int32, `HistoryLength` Int16, `BrowserLanguage` FixedString(2), `BrowserCountry` FixedString(2), `SocialNetwork` String, `SocialAction` String, `HTTPError` UInt16 CODEC (GCD,LZ4), `SendTiming` Int32, `DNSTiming` Int32, `ConnectTiming` Int32, `ResponseStartTiming` Int32, `ResponseEndTiming` Int32, `FetchTiming` Int32, `RedirectTiming` Int32, `DOMInteractiveTiming` Int32, `DOMContentLoadedTiming` Int32, `DOMCompleteTiming` Int32, `LoadEventStartTiming` Int32, `LoadEventEndTiming` Int32, `NSToDOMContentLoadedTiming` Int32, `FirstPaintTiming` Int32, `RedirectCount` Int8, `SocialSourceNetworkID` UInt8 CODEC (GCD,LZ4), `SocialSourcePage` String, `ParamPrice` Int64, `ParamOrderID` String, `ParamCurrency` FixedString(3), `ParamCurrencyID` UInt16 CODEC (GCD,LZ4), `GoalsReached` Array(UInt32) CODEC (GCD,LZ4), `OpenstatServiceName` String, `OpenstatCampaignID` String, `OpenstatAdID` String, `OpenstatSourceID` String, `UTMSource` String, `UTMMedium` String, `UTMCampaign` String, `UTMContent` String, `UTMTerm` String, `FromTag` String, `HasGCLID` UInt8 CODEC (GCD,LZ4), `RefererHash` UInt64 CODEC (GCD,LZ4), `URLHash` UInt64 CODEC (GCD,LZ4), `CLID` UInt32 CODEC (GCD,LZ4), `YCLID` UInt64 CODEC (GCD,LZ4), `ShareService` String, `ShareURL` String, `ShareTitle` String, `ParsedParams.Key1` Array(String), `ParsedParams.Key2` Array(String), `ParsedParams.Key3` Array(String), `ParsedParams.Key4` Array(String), `ParsedParams.Key5` Array(String), `ParsedParams.ValueDouble` Array(Float64), `IslandID` FixedString(16), `RequestNum` UInt32 CODEC (GCD,LZ4), `RequestTry` UInt8)
    ENGINE = MergeTree()
        PARTITION BY toYYYYMM(EventDate)
        ORDER BY (CounterID, EventDate, intHash32(UserID))
        SAMPLE BY intHash32(UserID);


INSERT INTO hits_gcd SELECT * FROM hits;
SELECT * FROM hits_gcd FORMAT Null;

DROP TABLE IF EXISTS hits_gcd;