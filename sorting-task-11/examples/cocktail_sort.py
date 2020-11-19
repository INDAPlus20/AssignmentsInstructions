def cocktailSort(list):
    sorted = False
    start = 0
    end = len(list)-1
    while (sorted == False):

        sorted = True

        for i in range(start, end):
            if (list[i] > list[i + 1]):
                swap(list[i], list[i+1])
                sorted == False
 
        if (sorted == True):
            break

        sorted = True

        end = end-1

        for i in range(end-1, start-1, -1):
            if (list[i] > list[i + 1]):
                swap(list[i], list[i+1])
                sorted = False

        start = start + 1


def swap(a, b):
    a, b = b, a