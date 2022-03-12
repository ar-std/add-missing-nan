# add-missing-nan

## Syntax

```plaintext
add-missing-nan.ps1
    [-InputFile] <String>
    [-OutputFile] <String>
    [[-NaNString] <String>]
```

## Description

This script is adding missing NaN values into XYZ stream.

For some plotting tools it is necessary that the input data forms a uniform "net".

Example:

```plaintext
1   1   2
2   1   4
3   1   8

1   2   1
2   2   1
3   2   2

1   3   3
2   3   1
3   3   4
```

Here, for each position of the `3x3` matrix a valid z-value is given.
If a z-value is missing, some tools skip that line in their output:

```plaintext
1   1   2
2   1   4

1   2   1
3   2   2

1   3   3
2   3   1
```

That is leading to problems, if you are trying to plot the data with a tool that needs a complete matrix.
This script is adding the missing x-y-pairs with `NaN` as z-value:

```plaintext
1   1   2
2   1   4
3   1   NaN

1   2   1
2   2   NaN
3   2   2

1   3   3
2   3   1
3   3   NaN
```

The output is sorted by the second row (as in the example).

## Parameters

`-InputFile`: Path to the input file

`-OutputFile`: Path to the output file

`-NaNString`: String that used as z-value for missing x-y-pairs (default: `NaN`)

## License

This code is licensed under the [UNLICENSE](UNLICENSE).
So you can do wat you want.
But ... I must admit, that I am bit curious.
If you want, you can [leave a message](mailto:ar-std@mailbox.org?subject=add-missing-nan) and tell me what you are using the script for. Or start a duscussion, if you like to share your use case with others.
