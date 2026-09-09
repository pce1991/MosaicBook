Graphs are one of the most interesting and versatile data structures in computer science. A graph consists of two types of data: `nodes` and `edges`. You can think of a node as a location in your graph and the edges as how you move between nodes. An edge could be bidirectional, meaning if you have an edge between two nodes `A` and `B` you could go between either one, or it might be one-way, meaning you could go from `A` to `B`, but not from `B` to `A`. 

Graphs are very useful for all types of data that you want to associate in games. For example a dialogue system could be thought of as a graph where each node is a line of dialogue for an NPC, and each edge is a line of dialogue for the player so you arrive at difference responses based on your choices. Graphs also show up in animation where you have a specific way you can get from one animation to another. For example you can't go from `Idle` to `Sprinting`, you have to go `Idle -> Windup -> Sprinting`. A graph can be used to represent a navigation mesh where each triangle in the mesh has edges to neighboring triangles, that way an NPC can find a path from one location to another by knowing which nodes it needs to walk thru. 

The data stored on edges and nodes can vary by what they're representing. For example in a dialogue tree an edge might also have flags that determine whether a line of dialogue is available or not, or perhaps they have a resource cost. 

Trees are a more restricted version of graphs where all edges only go one way, and you can never have an edge that connects a node to a node at a lower "depth." Think of different dialogue systems in games: in some systems you could ask a character a question and after they've answered it you return to another topic; this is a graph. In other games tho the conversation may just end since you've reached the end of the tree. 

A linked list is a natural way to represent a graph or a tree, but you can also do it with arrays. Let's look at an implementation.

```
struct Node {
   char *name;
   // node specific data, like an animation name or a line of dialogue
};

struct Edge {
    int32 nodeIndexA;
    int32 nodeIndexB;
    
    bool bidirectional;
    
    // edge specific data like requirements to be able to traverse the edge
};

struct Graph {
   DynamicArray<Node> nodes;
   DynamicArray<Edge> edges;
   
   int32 nodeIndex;
};

void AddNode(Graph *graph, char *name) {
   Node node = {};
   node.name = name;
   PushBack(&graph->nodes, node);
}

void AddEdge(Graph *graph, int32 nodeIndexA, int32 nodeIndexB) {
   Edge edge = {};
   edge.nodeIndexA = nodeIndexA;
   edge.nodeIndexB = nodeIndexB;
   PushBack(&graph->edges, edge);
}
// but what if you don't know what the index of a node is?

int32 GetNodeIndex(Graph *graph, char *name) {
   int32 index = -1;
   for (int i = 0; i < graph->nodes.count; i++) {
     if (StringEquals(graph->nodes[i].name, name)) {
       index = i;
       break;
     }
   }
   
   return index;
}
```

In this representation the node doesn't know what edges it has. You could give a node an array of indices for the nodes. In a tree it could make sense for a node to store the edges itself because all edges only go out of a node and nothing every comes back. 

```
void GetEdges(Graph *graph, int32 nodeIndex, DynamicArray<int32> *edgeIndices) {
   Node *node = &graph->nodes[nodeIndex];
   
   for (int i = 0; i < graph->edges.count; i++) {
      if (graph->edges[i].nodeIndexA == nodeIndex) {
      	PushBack(edgeIndices, i);
      }
      else if (graph->edges[i].bidirectional && graph->edges[i].nodeIndexB) {
        PushBack(edgeIndices i);
      }
   }
}
```

You can use an index to represent which node you're on in your graph, but of course sometimes that it might be the entities in your game that store where they're at in a graph, such as a navigation mesh. 

In many cases graphs and trees are stable data structures, meaning that you aren't adding and removing nodes or edges at runtimes. If you are tho that might be a case where a linked list is a good data structure. In the example code above if you start removing nodes all the edge indices will be broken, which would not happen if they were just pointing to a stable memory address of an element in a linked list. 