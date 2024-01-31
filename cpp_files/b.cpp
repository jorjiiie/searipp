template <typename T> T f(T x) {
    T y = x * 2;
    return y * x;
}
template<> int f<int>(int x) {
    int y = x * 2;
    return y * x;
}
template<> long long f<long long>(long long x) {
    long long y = x * 2;
    return y * x;
}
template <typename T, typename U> U mx(T x, U y) {
    return x > y ? x : y;
}
template<> int mx<long long, int>(long long x, int y) {
    return x > y ? x : y;
}
long long do_something() {
    int x = f(42) + f(33LL);
    return mx(69LL, x);
}
