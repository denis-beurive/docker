# Go templates

## Actions

"Actions" are delimited by "`{{`" or "`{{- `" and "`}}`" or "` -}}`". Actions are:

* data evaluations
* control structures

"`{{- `" and "` -}}`" are used to trim white spaces.

* "`{{- `" trims white spaces between the evaluated data and what **precedes** it.
* "` -}}`" trims white spaces between the evaluated data and what **follows** it.

Please note that:

* there is **no space** between the (opening or closing) brace and "`-`".
* there is (at least) **one space** between "`-`" and the data being evaluated.

That is:

* `'precede {{ - "2"}}'` is **NOT** valid.
* `'precede {{- "2"}}'` is valid (result: `precede2`).
* `'precede {{-  "2"}}'` is valid (result: `precede2`).
* `'precede {{-"2"}}'` is **NOT** valid.

## Data evaluation

### Basic examples

    --format '{{"2"}}'
    2

    --format '< {{"2"}} >'
    < 2 >

    --format '<{{"2"}}>'
    <2>

    --format '< {{  "2"  }} >'
    < 2 >

### Trimming

    --format '< {{- "2"}} >'
    <2 >

    --format '< {{"2" -}} >'
    < 2>

    --format '< {{- "2" -}} >'
    <2>

### Function calls

    --format '<{{ printf "%03d" 10 }}>'
    <010>

    --format '<{{ printf "|%03d|%-3d|" 10 5}}>'
    <|010|5  |>

> The list of available functions is given [here](https://golang.org/pkg/text/template/).

## Control structures

### Template definition

Define a template:

    --format '{{define "T1"}}ONE{{end}}'

Please note:

    --format '<{{define "T1"}}ONE{{end}}>'
    <>

Define a template and use it:

    --format '{{define "T1"}}ONE{{end}} {{template "T1"}}'
     ONE

    --format '{{define "T1"}}ONE{{end}} {{- template "T1"}}'
    ONE

### Variable definition

#### Simple scalars

    --format '{{$v1 := 1}}'

> Do not forget the leadind `$`!

    --format '{{$v1 := 1}}<{{$v1}}>'
    <1>

    --format '{{$v1 := 1}}{{ printf "This is %d" $v1 }}'
    This is 1

    --format '{{$v1 := 1}}{{$v2 := 10}}<{{ printf "This v1=%d v2=%d" $v1 $v2 }}>'
    <This v1=1 v2=10>

#### Maps and arrays

You cannot define maps or arrays within a template definition. See [this document](https://stackoverflow.com/questions/25012467/golang-templates-how-to-define-array-in-a-variable).

#### Making a variable "local"

    --format '{{with $v := "Joe"}}His name is {{$v}}.{{end}} {{with $v := "Bill"}}His name is {{$v}}{{end}}'
    His name is Joe. His name is Bill

### Conditionnl evaluation

    --format '<{{if 1}} toto {{end}}>'
    < toto >

    --format '<{{if 0}} toto {{end}}>'
    <>

    --format '<{{if 1}} true {{else}} false {{end}}>'
    < true >

    --format '<{{if and 1 1}} true {{else}} false {{end}}>'
    < true >

    --format '<{{if and 1 0}} true {{else}} false {{end}}>'
    < false >

    --format '<{{if and 1 0 1}} true {{else}} false {{end}}>'
    < false >

    --format '{{$v1:=1}}{{if gt $v1 10}}v1 is greater then 10{{else}}v1 is smaller then 10 {{end}}'
    v1 is smaller then 10 

Composed tests: the sub expressions must be explicitly identified using brackets "(`sub expression)`".

    --format '{{$v:=3}}{{$min:=1}}{{$max:=10}}{{if and (gt $v $min) (lt $v $max)}} {{- $min}} < {{$v}} < {{$max -}} {{end}}'
    1 < 3 < 10

## Working with maps and arrays

* `index`: `index x 1 2 3` is `x[1][2][3]`.
* `range`: If a "range" action initializes a variable, the variable is set to the successive elements of the iteration. Also, a "range" may declare two variables, separated by a comma.

> `index` and `range` can be used in conjonction with `with` (to produce local variables).



