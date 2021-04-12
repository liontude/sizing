# sizing
## Getting Started

### Adding package

```yaml
sizing: ^1.0.0
```

### Importing package

```yaml
import 'package:sizing/sizing.dart';
```

## Example

```dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return SizingBuilder(
        systemFontScale: false,
        builder: () => MaterialApp(
                ...
            ),
        );
    }
}
```

```dart
Container(
    padding: EdgeInsets.all(10),
    width: 100.s,
    height: 100.s,
    color: Colors.cyan[600],
    child: FittedBox(
    fit: BoxFit.fitWidth,
    child: Text(
                'Scale\nwidth: 100.s\nheight: 100.s',
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                ),
            ),
        ),
    ),
Container(
    padding: EdgeInsets.all(10),
    width: 100.ss(),
    height: 100.ss(),
    color: Colors.cyan[600],
    child: FittedBox(
    fit: BoxFit.fitWidth,
    child: Text(
            'Smart Scale\nwidth: 100.ss\nheight: 100.ss',
            textAlign: TextAlign.center,
            style: TextStyle(
            color: Colors.white,
            ),
        ),
    ),
),
Text(
    'fontSize: 16.fs(false) | Font Scale ${num.parse(16.fs().toStringAsFixed(2))}',
    textAlign: TextAlign.center,
    style: TextStyle(
    fontSize: 16.fs(),
    height: 1.5,
    ),
),
Text(
    'fontSize: 16.fss() | Font Smart Scale ${num.parse(16.fss(factor: 2).toStringAsFixed(2))}',
    style: TextStyle(
    fontSize: 16.fss(),
    height: 1.5,
    ),
),
SizedBox(
    height: 10.vs,
),
```

## License

    MIT License
