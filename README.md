# publish-game

GitHub Action for publishing WebGL games to [Final Parsec](https://www.finalparsec.com).

Relies on the Final Parsec API documented here: https://www.finalparsec.com/docs.

## Inputs

## `game-name`

**Required** The name of the game to publish. Default `"Untitled Game"`.

## `asset-directory`

**Required** The directory containing assets to be published. Default `"fp-publish"`

## Outputs

## `time`

The time the game was published.

## Example usage

```
uses: Final-Parsec/publish-game@v1
with:
  game-name: 'Aurora Tower Defense'
```
