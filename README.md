# TRPKeysGenerator
Primary &amp; Foregin Key Generator that maps ESPN Player IDs to Fangraphs Player IDs.  
To be run after generating an ESPN Players json file for top eligible players and before generating TRProjections.

## Dependancies
1. Generate ESPN Players JSON file from [ESPN_FantasyPlayerList](https://github.com/trpubz/ESPN_FantasyPlayerList)
2. Retrieve Fangraphs ATC projections and remove vertical divider from .csv [manual process]

## Outputs
- .json file with following schema
```
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "_name": {
        "type": "string"
      },
      "firstName": {
        "type": "string"
      },
      "idESPN": {
        "type": "string"
      },
      "idFangraphs": {
        "type": "string"
      },
      "idSavant": {
        "type": "string"
      },
      "lastName": {
        "type": "string"
      },
      "pos": {
        "type": "string"
      },
      "tm": {
        "type": "string"
      }
    },
    "required": [
      "_name",
      "firstName",
      "idESPN",
      "idFangraphs",
      "idSavant",
      "lastName",
      "pos",
      "tm"
    ]
  }
}
```

