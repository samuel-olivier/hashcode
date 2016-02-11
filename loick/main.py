#!/usr/bin/python

import math

class WareHouse:
  row = 0
  column = 0
  itemsNumber = []
  idx = 0

  def __repr__(self):
    return '[row:'+str(self.row)+',column:'+str(self.column)+',itemsNumber:'+str(self.itemsNumber)+']'

class Product:
  weight = 0
  def __repr__(self):
    return '[weight:'+str(self.weight)+']'

class Order:
  row = 0
  column = 0
  items = []
  idx = 0
  taken = False
  def __repr__(self):
    return '[row:'+str(self.row)+',column:'+str(self.column)+',items:'+str(self.items)+',taken:'+str(self.taken)+']'

class Drone:
  row = 0
  column = 0
  turn = 0
  load = 0
  target = None
  idx = 0
  def __repr__(self):
    return '[row:'+str(self.row)+',column:'+str(self.column)+',load:'+str(self.load)+',turn:'+str(self.turn)+']'

def dist(a, b):
  return math.sqrt((a.row - b.row) ** 2 + (a.column - b.column) ** 2)



numberRows, numberColumns, D, deadline, maximumLoad = map(int, raw_input().split())
numberProducts = int(raw_input())
productsWeight = map(int, raw_input().split())
commands = []

# Products
products = []
for weight in productsWeight:
  p = Product()
  p.weight = weight
  products.append(p)

# Warehouses
W = int(raw_input())
wareHouses = []
for i in range(W):
  w = WareHouse()
  w.row, w.column = map(int, raw_input().split())
  w.itemsNumber = map(int, raw_input().split())
  w.idx = i
  wareHouses.append(w)

drones = []
for i in range(D):
  drone = Drone()
  drone.row, drone.column = wareHouses[0].row, wareHouses[0].column
  drone.idx = i
  drones.append(drone)

def comparison(a, b):
  if products[b].weight == products[a].weight:
    return b - a
  return products[b].weight - products[a].weight

# Orders
C = int(raw_input())
orders = []
for i in range(C):
  o = Order()
  o.row, o.column = map(int, raw_input().split())
  raw_input()
  o.items = map(int, raw_input().split())
  o.items = sorted(o.items, cmp=comparison)
  o.idx = i
  orders.append(o)

#print numberRows, numberColumns, D, deadline, maximumLoad
def orderHeuristic(order):
  pass



def moveDrone(drone):

  # Get neerest order
  allOrders = []
  for order in orders:
    if not order.taken:
      allOrders.append([dist(drone, order), order])
  allOrders.sort()
  if len(allOrders) == 0 and drone.target == None:
    return False

  if drone.target != None:
    neerestOrder = drone.target
  else:
    neerestOrder = allOrders[0][1]

  # Get nearest wareHouse
  allWarehouses = []
  for wareHouse in wareHouses:
    allWarehouses.append([dist(wareHouse, neerestOrder), wareHouse])
  allWarehouses.sort()

  # Check items
  for wareHouse in allWarehouses:
    wareHouse = wareHouse[1]
    found = False
    itemToRemove = []
    for item in neerestOrder.items:
      if wareHouse.itemsNumber[item] > 0:
        if drone.load + products[item].weight > maximumLoad:
          break
        wareHouse.itemsNumber[item] -= 1
        itemToRemove.append(item)
        found = True
        drone.load += products[item].weight
    if found:

      # Map of items
      itemsToCarry = {}
      for item in itemToRemove:
        if item in itemsToCarry:
          itemsToCarry[item] += 1
        else:
          itemsToCarry[item] = 1

      #Compute turns
      for i in itemsToCarry:
        drone.turn += math.ceil(dist(drone, wareHouse)) + 1
        drone.row, drone.column = wareHouse.row, wareHouse.column
      for i in itemsToCarry:
        drone.turn += math.ceil(dist(drone, neerestOrder)) + 1
        drone.row, drone.column = neerestOrder.row, neerestOrder.column

      drone.load = 0
      if drone.turn >= deadline:
        for item in itemToRemove:
          wareHouse.itemsNumber[item] += 1
        if drone.target != None:
          drone.target.taken = False
        return True

      drone.target = neerestOrder
      neerestOrder.taken = True
      # Actually move
      for i in itemsToCarry:
        commands.append(str(drone.idx) + ' L ' + str(wareHouse.idx) + ' ' + str(i) + ' ' + str(itemsToCarry[i]))
      for i in itemsToCarry:
        commands.append(str(drone.idx) + ' D ' + str(neerestOrder.idx) + ' ' + str(i) + ' ' + str(itemsToCarry[i]))

      #print 'Go to order', neerestOrder
      for i in itemToRemove:
        neerestOrder.items.remove(i)
      if len(neerestOrder.items) == 0:
        orders.remove(neerestOrder)
        drone.target = None
      #print drone.turn, deadline
      return False

while len(orders) and len(drones):
  #print orders, drones
  next = []
  for drone in drones:
    if not moveDrone(drone):
      next.append(drone)
  drones = next

print len(commands)
print '\n'.join(commands)
