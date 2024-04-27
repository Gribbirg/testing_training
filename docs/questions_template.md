# Questions data json templates

### One select

```json
{
  "name": "Question",
  "number": 0,
  "type": "oneselect",
  "image": null,
  "right_ans_num": 0,
  "answers_count": 2,
  "answers": [
    {
      "number": 0,
      "image": null,
      "text": "Answer 1"
    },
    {
      "number": 1,
      "image": null,
      "text": "Answer 2"
    }
  ]
}
```

### Multi select

```json
{
  "name": "Question",
  "number": 0,
  "type": "multselect",
  "image": null,
  "right_answers_nums": [
    0,
    1
  ],
  "answers_count": 2,
  "answers": [
    {
      "number": 0,
      "image": null,
      "text": "Answer 1"
    },
    {
      "number": 1,
      "image": null,
      "text": "Answer 2"
    }
  ]
}
```

### Order

```json
{
  "name": "Question",
  "number": 0,
  "type": "order",
  "image": null,
  "right_answers_nums": [
    0,
    1
  ],
  "answers_count": 2,
  "answers": [
    {
      "number": 0,
      "image": null,
      "text": "Answer 1"
    },
    {
      "number": 1,
      "image": null,
      "text": "Answer 2"
    }
  ]
}
```

### Categories

```json
{
  "name": "Question",
  "number": 0,
  "type": "categories",
  "image": null,
  "right_answers_nums": [
    0,
    1,
    2
  ],
  "statements_count": 3,
  "statements": [
    {
      "number": 0,
      "image": null,
      "text": "Statement 1"
    },
    {
      "number": 1,
      "image": null,
      "text": "Statement 2"
    },
    {
      "number": 2,
      "image": null,
      "text": "Statement 3"
    }
  ],
  "answers_count": 3,
  "answers": [
    {
      "number": 0,
      "image": null,
      "text": "Answer 1"
    },
    {
      "number": 1,
      "image": null,
      "text": "Answer 2"
    },
    {
      "number": 2,
      "image": null,
      "text": "Answer 3"
    }
  ]
}
```

### String

```json
{
  "name": "Question",
  "type": "string",
  "answer": "Answer",
  "variants": ["Variant 1", "Variant 2"],
  "number": 0,
  "image": null
}
```

### Number

```json
{
  "name": "Question",
  "type": "num",
  "unit": "",
  "delta": 0.1,
  "answer": 2.0,
  "number": 0,
  "image": null
}
```