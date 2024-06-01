import 'package:flutter/material.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}




function SmithWaterman(seq1, seq2, match_score, mismatch_penalty, gap_penalty)
    # Initialize the scoring matrix
    let n = length(seq1)
    let m = length(seq2)
    let matrix = matrix of size (n+1) x (m+1)
    let max_score = 0
    let max_position = (0, 0)
    # Initialize first row and column of the matrix with 0s
    for i from 0 to n
        matrix[i][0] = 0
    for j from 0 to m
        matrix[0][j] = 0
    # Fill the matrix based on score of alignments
    for i from 1 to n
        for j from 1 to m
            if seq1[i-1] == seq2[j-1]
                score = match_score
            else
                score = mismatch_penalty
            matrix[i][j] = max(
                0,
                matrix[i-1][j-1] + score,  # Match/mismatch
                matrix[i-1][j] + gap_penalty,  # Gap in seq2
                matrix[i][j-1] + gap_penalty   # Gap in seq1
            )
            # Keep track of the maximum score
            if matrix[i][j] > max_score
                max_score = matrix[i][j]
                max_position = (i, j)
