@possibleCombinationSum = (arr, n) ->
  if arr.indexOf(n) >= 0
    true
  if arr[0] > n
    false
  if arr[arr.length - 1] > n
    arr.pop()
    possibleCombinationSum(arr, n)
  listSize = arr.length
  combinationsCount = 1 << listSize
  i = 1
  while i < combinationsCount
    combinationSum = 0
    j = 0
    while j < listSize
      if i & 1 << j
        combinationSum += arr[j]
      j++
    if n == combinationSum
      true
    i++
  false