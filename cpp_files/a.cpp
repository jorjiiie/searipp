template <typename T> T f(T x) {
  T y = x * 2;
  return y * x;
}
template <typename T, typename U> U mx(T x, U y) { return x > y ? x : y; }

long long do_something() {
  int x = f(42);
  return mx(69LL, x);
}
